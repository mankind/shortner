# Add the root to the load path.
$LOAD_PATH << File.dirname(__FILE__)

# run the app
require 'rubygems'
require 'sinatra' 
require 'shortner'

run Shortner