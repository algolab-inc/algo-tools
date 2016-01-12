require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module AlgolabTools
  class Application < Rails::Application
    config.generators.template_engine = :slim
    config.generators.test_framework = :rspec
    config.generators.stylesheets = false
    config.generators.javascripts = false
    config.generators.helper = false
  
    config.active_record.raise_in_transactional_callbacks = true
  end
end
