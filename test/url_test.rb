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

class UrlTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end
  
   def setup
    @valid_params = {:url => 'http://www.sinatrarb.com', 
	                 :with => URI::regexp(%w(http https))
					 }
   end
   
   def teardown
    Url.delete_all
   end
  
  def test_not_valid_without_url
  u = Url.new(@valid_params.merge(:url => nil))
  assert !u.valid?
  assert u.errors#[:url]
  end
  
  def test_it_validates_format_of_url
   u = Url.new(@valid_params.merge(:url => 'google', :with => URI::regexp(%w(http https))  ))
   assert !u.valid?
   assert u.errors#[:url, :with]
  end
  
  def test_empty_shortened_url
    short_url = Url.new
    assert_equal false, short_url.save
  end
  
  def test_invalid_shortened_url
    matchers = ['google', 'http://london.a', 'http://google']
    for matcher in matchers
      short_url = Url.new(:url => matcher)
     # assert_equal false
	 assert !short_url.valid? 
    end
  end

 
end 