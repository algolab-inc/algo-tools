class CalendarReport
  include ActiveModel::Model
  include Virtus.model

  attribute :id,           String,  default: lambda { |page, attrs| SecureRandom.uuid }
  attribute :provider_id,  Integer, default: lambda { |page, attrs| Provider.first.id }
  attribute :start_on,     Date,    default: lambda { |page, attrs| Date.current.prev_month }
  attribute :end_on,       Date,    default: lambda { |page, attrs| Date.current }
  attribute :delimiter_id, Integer, default: lambda { |page, attrs| CalendarReportDelimiter.first.id }
  attribute :is_persisted, Boolean, default: false
  attribute :email,        String
  attribute :credentials,  Hash

  validates_date :start_on, allow_blank: false
  validates_date :end_on,   allow_blank: false,
                            on_or_before: lambda { |attrs| attrs.start_on + 3.months },
                            on_or_before_message: 'は開始日から3ヶ月以内にしてください',
                            on_or_after: :start_on,
                            on_or_after_message: 'は開始日以降にしてください'
  def self.demo
    self.new({
      email: 'algotools@example.com',
      is_persisted: true
    })
  end

  def persisted?
    is_persisted
  end

  def expired?
    credentials['expires_at'] - Time.current.to_i < 60 * 5
  end

  def provider
    Provider.find_by_id(provider_id)
  end

  def delimiter
    CalendarReportDelimiter.find_by_id(delimiter_id)
  end

  def title
    "#{start_on.try(:strftime, '%Y-%m-%d')} - #{end_on.try(:strftime, '%Y-%m-%d')} (#{email})"
  end

  def google_event_summaries
    Hash.new{|h,k| h[k] = {}}.tap do |res|
      res[:trees] = GoogleApiClient.new(
        credentials,
        time_min: start_on.beginning_of_day.iso8601,
        time_max: end_on.end_of_day.iso8601
      ).events.each_with_object(
        Hash.new{|h1,k1| h1[k1] = Hash.new{|h2,k2| h2[k2] = {}}}
      ) {|event,trees|
        del_l, del_r = delimiter.value.split.map{|d| Regexp.escape(d)} rescue ['', '']
        if (summaries = event.summary.scan(/#{del_l}[^#{del_l}|^#{del_r}]*#{del_r}/)).present?
          start_time = Time.parse((event.start.date_time || event.start.date).to_s)
          end_time   = Time.parse((event.end.date_time   || event.end.date  ).to_s)
          time = (end_time - start_time) / (60 * 60)
          summaries.each_with_index.with_object([]) do |(summary,i),parent_ids|
            summary.gsub!(/(^#{del_l}|#{del_r}$)/,'')
            depth = i + 1
            parent_id = depth > 1 ? parent_ids[depth - 2] : 'top'
            trees[depth][parent_id][summary] ||= EventSummary.new({
              title: summary,
              parent_id: parent_id,
              depth: depth
            })
            trees[depth][parent_id][summary].time += time
            trees[depth][parent_id][summary].daily_data[start_time.beginning_of_day.to_s] += time
            parent_ids << trees[depth][parent_id][summary].id
          end
        end
      }.merge(
        EventSummary.top_tree
      ).each_with_object({}) {|(k1,v1),trees1|
        trees1[k1] =  v1.each_with_object({}) {|(k2,v2),trees2|
          trees2[k2] = v2.values.map {|v3|
            res[:ids][v3.id] ||= v3
          }.sort {|a,b|
            b.time <=> a.time
          }
        }
      }
    end
  end
end
