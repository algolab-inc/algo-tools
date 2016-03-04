class ErrorsController < ApplicationController
  def show
    exception = env['action_dispatch.exception']
    ExceptionNotifier.notify_exception(exception, env: env)
    @error = Error.find_by_code(ActionDispatch::ExceptionWrapper.new(env, exception).status_code)
    respond_to do |format|
      format.html { render :show }
      format.all { render nothing: true, status: @error.code }
    end
  end
end
