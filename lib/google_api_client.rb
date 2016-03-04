require 'google/apis/calendar_v3'

class GoogleApiClient
  def initialize(credentials, options = {})
    @credentials = credentials
    @options = options
  end

  def calendar_service
    @calendar_service ||= Google::Apis::CalendarV3::CalendarService.new.tap{|c|
      c.authorization = @credentials['token']
    }
  end

  def calendars
    @calendars ||= calendar_service.list_calendar_lists
  end

  def events
    calendars.items.map{|calendar|
      calendar_service.list_events(
        calendar.id,
        max_results: 2500,
        time_min:    @options[:time_min],
        time_max:    @options[:time_max]
      ).items
    }.flatten
  end
end
