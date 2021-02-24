require "sinatra"
require "sinatra/reloader" if development?

class AtelierRemote < Sinatra::Base
  get '/' do
    'Hello world!'
  end
end
