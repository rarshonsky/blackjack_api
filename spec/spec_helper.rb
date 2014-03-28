require 'rubygems'
require 'factory_girl'


ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)
#Dir[Rails.root.join("spec/factories/**/*.rb")].each {|f| require f}
require 'rspec/rails'
RSpec.configure do |config|
  config.mock_with :rspec
  config.expect_with :rspec
  config.include RSpec::Rails::RequestExampleGroup, type: :request, example_group: {
    file_path: /spec\/api/
  }
end

require 'capybara/rspec'
