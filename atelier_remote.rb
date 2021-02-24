require 'sinatra'
require "sinatra/config_file"
require 'sinatra/reloader'
require "sinatra/json"

require_relative 'remote'

class AtelierRemote < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  register Sinatra::ConfigFile
  config_file 'config.yml'

  get '/config' do
    json development: settings.development?, connection: settings.connection
  end
end
