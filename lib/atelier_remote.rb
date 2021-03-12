# frozen_string_literal: true

require 'sinatra'
require 'sinatra/config_file'
require 'sinatra/reloader'
require 'sinatra/json'
require 'sinatra/namespace'

require_relative 'remote'

class AtelierRemote < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end
  register Sinatra::Namespace
  register Sinatra::ConfigFile
  config_file '../config.yml'

  namespace '/api' do
    post '/command' do
      payload = JSON.parse(request.body.read).transform_keys(&:to_sym)

      begin
        remote.call(payload[:cmd])
        halt 201
      rescue Remote::Error => e
        status 404
        json message: e.message
      rescue Errno::ENOENT, Errno::EBUSY => e
        status 504
        json message: e.message
      end
    end
  end

  get '/commands' do
    json commands: Remote::CMD_LIST.keys
  end

  get '/config' do
    json development: settings.development?, connection: settings.connection
  end

  def remote
    Remote.new(**settings.connection.to_h.transform_keys(&:to_sym))
  end
end
