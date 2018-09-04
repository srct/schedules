Apipie.configure do |config|
  config.app_name                = "SRCT Schedules API"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/api"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
  config.api_routes = Rails.application.routes

  # use Markdown for writing docs
  config.markup = Apipie::Markup::Markdown.new

  # Fixes annoying "can't find resource" bug, see https://github.com/Apipie/apipie-rails/issues/549
  config.translate = false
  config.default_locale = nil

  config.app_info["1.0"] = "The SRCT Schedules API provides data about courses, sections, and professors offered at GMU."
end
