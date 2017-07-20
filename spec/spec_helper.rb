require_relative '../app.rb'
require 'rspec'
require 'rack/test'
require 'ffaker'
require 'pg_search'
#importa todos os arquivos que estão na pasta support
Dir["./spec/support/**/*.rb"].each { |file| require file }
Dir["./app/services/**/*.rb"].each {|file| require file }

set :environment, :test

module RSpecMixin
  include Rack::Test::Methods

  def app
    App
  end
end

RSpec.configure do |c|
  c.include RSpecMixin
  #ajuda a ficar com menos log's
  ActiveRecord::Base.logger = nil unless ENV['LOG'] == true
end
