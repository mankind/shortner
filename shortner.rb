require 'rubygems'
require 'sinatra'
require 'mongoid'
require './models/url'


class Shortner < Sinatra::Base

# setting up the mongodb db name and connection
Mongoid.load!("./config/mongoid.yml")


  get '/' do
    erb :index
  end

  post '/' do
    @short_url = Url.find_or_create_by_url(params[:url])
    if @short_url.valid
      erb :success
    else
      erb :index
    end
   end

   get '/:shortened' do
      short_url = Url.find_by_shortened(params[:shortened])
      redirect short_url.url
   end

end
# Sends people from the shoretened url to their destination


