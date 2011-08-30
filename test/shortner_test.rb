require 'rubygems'
require 'sinatra'
require 'bundler'
Bundler.setup
Bundler.require(:default, :test)
require './shortner'
require 'rack/test'
require 'test/unit'
require 'alphadecimal'

ENV['RACK_ENV'] = 'test'

class ShortnerTest < Test::Unit::TestCase

 include Rack::Test::Methods

  def app
    Sinatra::Application
  end
  
  def it_redirects_to_new
   get '/new'
   assert last_response.ok? 
  end
  
  def it_redirects_to_new
   get '/post'
   assert last_response.ok? 
  end
  
  def test_shortened_exists
    u = Shortner.new
	u.shorter
	assert u.valid?
  end

end