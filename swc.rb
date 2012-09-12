require 'bundler/setup'

require 'sinatra/base'
require 'sinatra/support'
require 'sass'
require 'compass'
require 'bootstrap-sass'
require 'sprockets'
require 'sprockets/helpers'
require 'sprockets-sass'

# Helpers
require './lib/js_compressor'
require './lib/render_partial'

require 'yaml'

# ~/.rvm/gems/ruby-1.9.3-p194@swc4/gems/bootstrap-sass-2.1.0.0/vendor/assets/stylesheets

class Swc < Sinatra::Base
  set :root,          File.dirname(__FILE__)
  set :assets,        Sprockets::Environment.new(root)
  set :precompile,    [ /\w+\.(?!js|css).+/, /application.(css|js)$/ ]
  set :assets_prefix, '/assets'
  set :digest_assets, false
  set :haml,          { :format => :html5 }
  set :redirects,     {
    /^\/projektliste\.rtf/i => 'http://software-consultant.net/',
    /^\/projekte/i => 'http://software-consultant.net/#projekte',
    /^\/opensource\/osx-xing-vcard-utility/i => 'https://github.com/datenimperator/vcard-converter',
    /^\/opensource/i => 'https://github.com/datenimperator',
    /^\/assets\/1\/Vorstellung_Christian_Aust\.pdf/i => 'http://software-consultant.net/profil.pdf',
    /^\/assets\/2\/profil\.pdf/i => 'http://software-consultant.net/profil.pdf',
    /^\/impressum-kontakt/i => 'http://software-consultant.net/'
  }

  configure do
    # Setup Sprockets
    # assets.logger = Logger.new(STDOUT)
    %w{javascripts stylesheets images}.each do |type|
      assets.append_path "assets/#{type}"
      assets.append_path Compass::Frameworks['bootstrap'].templates_directory + "/../vendor/assets/#{type}"
    end
    assets.append_path "assets/font"

    # Configure Sprockets::Helpers (if necessary)
    Sprockets::Helpers.configure do |config|
      config.environment = assets
      config.prefix      = assets_prefix
      config.digest      = digest_assets
      config.public_path = public_folder
    end
    Sprockets::Sass.add_sass_functions = false

    if production?
      assets.js_compressor = JsCompressor.new if production?
      settings.haml[:ugly] = true
      Sprockets::Sass.options[:style] = :compressed
    end
  end

  before do
    expires 500, :public, :must_revalidate
  end

  get '/' do
    @projects = YAML::load_documents(File.read('projects.yml'))
    haml :index, :layout => :'layouts/application'
  end

  not_found do
    pass if settings.redirects.any? {|pattern, uri|
      if pattern.match(request.path)
        redirect to(uri), 301
        return true
      end
      false
    }
    haml :'404', :layout => :'layouts/application'
  end

  helpers do
    include Sprockets::Helpers
    include Rack::Utils
    include RenderPartial

    def production?
      Swc.production?
    end

  end

end
