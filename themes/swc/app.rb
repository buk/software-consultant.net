# Use the app.rb file to load Ruby code, modify or extend the models, or
# do whatever else you fancy when the theme is loaded.

require 'active_support/core_ext/hash'
require 'sinatra/content_for'

$:.unshift File.join(File.dirname(__FILE__), 'lib')
require 'swc'

Encoding.default_external = 'utf-8'
module Nesta
  class App
    set :logger, Logger.new(STDOUT)

    configure do
      register SWC::Projects
      register SWC::Availability
      register SWC::Redirects
      register Sinatra::I18nSupport
      load_locales File.join(Env.root, 'config', 'locales')
      set :default_locale, 'de'
      if ENV['RACK_ENV'] == 'production'
        Sprockets::Sass.options[:style] = :compressed
      end
    end

    helpers do
      include Sinatra::ContentFor
      include Sprockets::Helpers
      include SWC::Helpers
    end
  end
end
