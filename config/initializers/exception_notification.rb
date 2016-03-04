require 'exception_notification/rails'

ExceptionNotification.configure do |config|
  config.add_notifier :slack, {
    webhook_url: Settings.slack.webhook_url,
    channel: Settings.slack.channel
  }
end if Rails.env.production?
