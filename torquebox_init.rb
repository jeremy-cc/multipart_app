require 'rubygems'

require 'sinatra'
require 'sinatra/reloader'
require 'app/web/adaptor'
require 'app/api_result'
require 'app/response_formatter_middleware'

Bundler.require(:default, settings.environment)

Sinatra::Base.enable :reloader

#we manually add files to watch for the reloader because it seems that dependencies
#below the 'get' and 'post' handlers are not picked up

Sinatra::Base.enable :dump_errors, :raise_errors
Sinatra::Base.disable :show_exceptions

ENV['RACK_ROOT'] ||= File.dirname('.')
Sinatra::Base.set :root, ENV['RACK_ROOT']

Sinatra::Base use Rack::Reloader
Sinatra::Base.use ResponseFormatterMiddleware
Sinatra::Base.use Rack::Parser

[
    "#{ENV['RACK_ROOT']}/app/web/adaptor",
    "#{ENV['RACK_ROOT']}/app/api_result",
    "#{ENV['RACK_ROOT']}/app/response_formatter_middleware"
].each { |path| Sinatra::Reloader::Watcher::List.for(TccWebAdaptor).watch_file(path) }
