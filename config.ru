require 'rubygems'
require 'bundler/setup'

Bundler.require(:default, (ENV["RACK_ENV"] || "development").to_sym)

# The project root directory
require 'nesta/env'
Nesta::Env.root = ::File.dirname(__FILE__)

# Load in our Nesta configs
nesta_config = YAML::load(File.open( File.join(Nesta::Env.root, 'config', 'config.yml')))
nesta_theme = nesta_config['theme']
nesta_content = nesta_config['content']

if ENV['RACK_ENV'] == 'production'
  # use Rack::ConditionalGet
  # use Rack::ETag
  use Rack::Cache
else
  # Nice looking errors
  use Rack::ShowExceptions
end

map Sprockets::Helpers.prefix do
  environment = Sprockets::Environment.new(Nesta::Env.root) do |env|
    env.append_path File.join(Nesta::Env.root, nesta_content, 'attachments')
    %w{javascripts stylesheets images fonts}.each do |type|
      if f = File.join(Nesta::Env.root, nesta_content, 'assets', type)
        env.append_path f if File.exist?(f)
      end
      if f = File.join(Nesta::Env.root, 'themes', nesta_theme, 'assets', type)
        env.append_path f if File.exist?(f)
      end
    end

    # Add zurb-foundation asset paths
    gem_root = Gem.loaded_specs['zurb-foundation'].full_gem_path
    env.append_path File.join(gem_root, 'js')
  end

  Sprockets::Helpers.configure do |config|
    config.environment = environment
    config.digest      = false
  end

  run environment
end

map "/" do
  require 'nesta/app'
  run Nesta::App
end
