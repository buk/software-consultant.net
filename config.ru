require 'rack/cache'
require './swc'

use Rack::Cache, verbose: false

map Swc.assets_prefix do
  run Swc.assets
end

map '/' do
  run Swc
end
