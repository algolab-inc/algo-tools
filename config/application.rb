require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module AlgoTools
  class Application < Rails::Application
    config.generators do |g|
      g.template_engine = :slim
      g.test_framework = :rspec
      g.stylesheets = false
      g.javascripts = false
      g.helper = false
    end
    config.autoload_paths += %W(#{config.root}/lib)
    config.i18n.default_locale = :ja
    config.time_zone = 'Tokyo'
    config.active_record.raise_in_transactional_callbacks = true
  end
end
