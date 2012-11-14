# encoding: utf-8

require 'sinatra/base'
require 'sinatra/support'
require 'sass'
require 'compass'
require 'bootstrap-sass'
require 'sprockets'
require 'sprockets/helpers'
require 'sprockets-sass'
require 'will_paginate/array'
require 'rtf'

# Helpers
require './lib/js_compressor'
require './lib/render_partial'
require './lib/swc_link_renderer'

require 'yaml'
require 'json'

# ~/.rvm/gems/ruby-1.9.3-p194@swc4/gems/bootstrap-sass-2.1.0.0/vendor/assets/stylesheets

class Swc < Sinatra::Base
  register Sinatra::I18nSupport
  load_locales './config/locales'
  set :default_locale, 'de'  # Optional; defaults to 'en'

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
    enable :logging if development?

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
    page = params[:page] || 1
    @query = params[:q] || ''
    @visible_projects = search_projects(@query == '' ? nil : @query.split(' ')).paginate( page: page, per_page: 5 )
    return haml :projects if request.xhr?

    haml :index, :layout => :'layouts/application'
  end

  get '/projects.json' do
    content_type :json

    terms = {}
    max = params['max'] ? params['max'].to_i : 0

    param_names.each do |name|
      terms[name] = params[name] if params[name]
    end

    search_projects(terms, max).to_json
  end

  get '/projects.rtf' do
    content_type :rtf
    projects_as_rtf
  end

  get '/availability.json' do
    content_type :json
    availability.to_json
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
    include ::Sprockets::Helpers
    include ::Rack::Utils
    include ::WillPaginate::Sinatra::Helpers
    include RenderPartial

    def production?
      Swc.production?
    end

    def language
      available = %w(de en)
      env.http_accept_language.compatible_language_from(available)
    end

    def projects
      @projects ||= begin
        logger.info "Reloading projects"
        YAML::load_documents(File.read('projects.yml'))
      end
    end

    def references
      @references ||= begin
        logger.info "Reloading references"
        YAML::load_documents(File.read('references.yml'))
      end
    end

    def availability
      {
        :free => 0.1,
        :next_full => Date.new(2013, 1, 1)
      }
    end
  end

  private

  def param_names
    @param_names ||= %w{ title description customer role tools }.map(&:to_sym)
  end

  def search_projects(terms, max=0)

    return projects[0..(max-1)] if terms.nil?
    terms = { :any=>terms } unless terms.is_a?(Hash)

    projects.find_all do |project|
      param_names.any? do |name|
        t = terms[name] || terms[:any]
        if t
          r1 = t.is_a?(Array) ? t.map{|term| Regexp.escape(term.to_s) }.join('|') : Regexp.escape(t.to_s)
          r2 = Regexp.new("\\b(#{r1})\\b", true)
          name = name.to_s
          v = case project[name]
            when nil then ''
            when Array then project[name].join(' ')
            when String then project[name]
            else project[name].to_s
          end
          v =~ r2
        end
      end
    end[0..(max-1)]
  end

  def projects_as_rtf
    styles = {}
    styles['HEADER'] = ::RTF::CharacterStyle.new
    styles['HEADER'].bold      = true
    styles['HEADER'].font_size = 28
    styles['H1'] = ::RTF::CharacterStyle.new
    styles['H1'].bold      = true
    styles['H1'].font_size = 16
    styles['NORMAL'] = ::RTF::ParagraphStyle.new
    document = RTF::Document.new(RTF::Font.new(RTF::Font::ROMAN, 'Arial'))
    document.paragraph do |p|
      p.apply(styles['HEADER']) do |s|
        s << 'Projektübersicht'
      end
    end
    projects.each do |project|
      document.paragraph do |p|
        p.apply(styles['H1']) do |s|
          s << project['title']
        end
      end
      document.paragraph(styles['NORMAL']) do |p1|
        p1 << project['description']
      end
      document.line_break
    end
    document.to_rtf
  end

end
