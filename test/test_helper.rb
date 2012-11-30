ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'database_cleaner'

class ActiveSupport::TestCase
  include FactoryGirl::Syntax::Methods
  include Devise::TestHelpers
  # Add more helper methods to be used by all tests here...
  def setup
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
    raise NoMethodError
  rescue NoMethodError
  end
end
