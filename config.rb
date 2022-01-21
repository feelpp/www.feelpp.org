require 'time'

# Site properties (see data/site.yml for seed values)
ready do
  site_properties = app.data.site
  if (copyright = site_properties.copyright)
    site_properties.copyright = copyright.sub '{year}', Time.now.year.to_s
  end
  if app.server?
    site_properties.baseurl = %(http#{config.https ? 's' : ''}://#{config.server_name || 'localhost'}:#{config.port})
  elsif ENV['CONTEXT'] == 'deploy-preview' || ENV['CONTEXT'] == 'branch-deploy'
    site_properties.baseurl = ENV['DEPLOY_PRIME_URL']
  end
end

set :time_zone, 'America/Denver'

# Site structure
set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'img'
set :layouts_dir, '_layouts'
set :build_dir, 'public'

# Template engine config
autoload :Asciidoctor, 'asciidoctor'
set :slim, format: :html, sort_attrs: false, pretty: true, disable_escape: true
require 'slim/include'

# Page config
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false
page '/', layout: 'home'

# Activate Sprockets and wire to Node modules
activate :sprockets do |conf|
  conf.imported_asset_path = 'vendor'
end
sprockets.append_path File.join root, 'node_modules'
sprockets.append_path File.join root, 'node_modules/font-awesome/fonts'
#sprockets.css_compressor = ...

activate :asciidoc, attributes: ['idprefix=_', 'idseparator=-', 'sectanchors=', 'allow-uri-read']

activate :relative_assets
activate :directory_indexes

# NOTE: The `server` command defaults to the :development environment.
configure :development do
  activate :livereload if ENV['LIVE_RELOAD'] == 'true'
end

# NOTE: The `build` command defaults to the :production environment.
# https://antora.org
configure :production do
  set :http_prefix, (ENV.fetch 'HTTP_PREFIX', '/')
  config.slim[:indent] = ''
  activate :autoprefixer
  require_relative 'lib/css_compressor'
  activate :minify_css, compressor: CssCompressor
  activate :minify_javascript
  activate :google_analytics, tracking_id: 'UA-112324747-1', minify: true
end
