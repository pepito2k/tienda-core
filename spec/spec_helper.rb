require 'bundler/setup'
Bundler.setup

ENV["RAILS_ENV"] = "test"
require File.expand_path("../../test/app/config/environment.rb",  __FILE__)
require 'tienda'

# Factory Girl
require 'factory_girl'
FactoryGirl.find_definitions

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
end
