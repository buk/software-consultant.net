require 'bundler/setup'

require 'rack/cache'
require 'http_accept_language'
require './swc'

use HttpAcceptLanguage::Middleware
use Rack::Cache, verbose: false

map Swc.assets_prefix do
  run Swc.assets
end

map '/' do
  run Swc
end
