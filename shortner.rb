require 'rubygems'
require 'sinatra'
require 'mongoid'
require './models/url'
require 'alphadecimal'


class Shortner < Sinatra::Base 

# setting up the mongodb db name and connection
 #Mongoid.load!("./config/mongoid.yml")

#replaced Yaml file with the configuration below becuase of mongoid's validate_db_name
# The error is caused by changes in Rubygems parsing YAML files with 'syck' see the link below:
# https://github.com/mongoid/mongoid/issues/648
Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db("shortner")
end

get '/' do
  erb :index
end

post '/' do
  @short_url = Url.find_or_create_by_url(params[:url])
  if @short_url.valid?
    erb :success
  else
    erb :index
  end
end

#The redirect route block
get '/:shortened' do
  short_url = Url.find_by_shortened(params[:shortened])
  redirect short_url.url
end

end



