require 'rubygems'
require 'sitemap_generator'

SitemapGenerator::Sitemap.default_host = 'https://ecofnb.com'
SitemapGenerator::Sitemap.create do
  add '/ecofnb/index', :changefreq => 'daily', :priority => 0.9
  add '/ecofnb/all_stay_homes', :changefreq => 'daily', :priority => 0.9
  add '/stay_homes', :changefreq => 'weekly'
end
SitemapGenerator::Sitemap.ping_search_engines # Not needed if you use the rake tasks