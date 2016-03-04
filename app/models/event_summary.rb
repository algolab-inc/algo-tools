class EventSummary
  include Virtus.model
  attribute :id,         String,  default: lambda { |page, attrs| SecureRandom.uuid }
  attribute :parent_id,  String
  attribute :depth,      Integer, default: 0
  attribute :title,      String
  attribute :time,       Float,   default: 0
  attribute :daily_data, Hash

  def initialize(*args)
    super(*args)
    daily_data.default_proc = ->(h,k) { h[k] = 0 }
  end

  def self.top
    self.new(
      id: 'top',
      title: 'トップ'
    )
  end

  def self.top_tree
    self.top.tap {|top|
      return {
        top.depth => {
          top.parent_id => {
            top.title => top
          }
        }
      }
    }
  end

  def self.demo
    Hash.new{|h1,k1| h1[k1] = Hash.new{|h2,k2| h2[k2] = Hash.new{|h3,k3| h3[k3] = []}}}.tap do |res|
      YAML.load(ERB.new(File.read("#{Rails.root}/db/data/#{self.to_s.pluralize.underscore}.yml")).result).each do |params|
        EventSummary.new(params).tap do |e|
          res[:ids][e.id] = e
          res[:trees][e.depth][e.parent_id] << e
        end
      end
    end
  end
end
