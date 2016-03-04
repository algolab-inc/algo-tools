class CalendarReportsController < ApplicationController
  before_action :set_calendar_report, only: [:show, :update]
  after_action :store_calendar_report, only: [:create, :show, :update]

  def index
    @calendar_report = CalendarReport.new
  end

  def create
    @calendar_report = CalendarReport.new(calendar_report_params)
    if @calendar_report.valid?
      @calendar_report.is_persisted = true
      redirect_to_auth
    else
      render :index
    end
  end

  def show
    @calendar_report.attributes = {
      email: session[:auth]['info']['email'],
      credentials: session[:auth]['credentials']
    } if session[:auth]
    [:auth, :redirect_path].each { |attr| session.delete(attr) }
    redirect_to_auth if @calendar_report.expired?
  end

  def update
    @calendar_report.attributes = calendar_report_params
    if @calendar_report.valid?
      if @calendar_report.expired?
        redirect_to_auth
      else
        redirect_to calendar_report_path(@calendar_report)
      end
    else
      render :show
    end
  end

  private
  def calendar_report_params
    params.require(:calendar_report).permit(:start_on, :end_on, :delimiter_id)
  end

  def set_calendar_report
    @calendar_report = CalendarReport.new(session[:calendar_report])
    raise ActiveRecord::RecordNotFound unless @calendar_report.id == params[:id]
  end

  def store_calendar_report
    session[:calendar_report] = @calendar_report.to_hash
  end

  def redirect_to_auth
    session[:redirect_path] = calendar_report_path(@calendar_report)
    redirect_to "/auth/#{@calendar_report.provider.auth_key}"
  end

end
