
if Rails.env.test?
  RouteTranslator.config do |config|
    config.generate_unlocalized_routes = true
  end
end