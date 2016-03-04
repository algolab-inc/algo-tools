class EventSummariesController < ApplicationController
  def index
    if params[:demo]
      @event_summaries = EventSummary.demo
    else
      CalendarReport.new(session[:calendar_report]).tap {|calendar_report|
        @event_summaries = calendar_report.send("#{calendar_report.provider.name}_event_summaries".to_sym)
      }
    end
    render json: @event_summaries
  end
end
