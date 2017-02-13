#
# Cookbook:: test_rubygems
# Recipe:: bundle_config
#
# Copyright:: 2016-2017, Ryan Hass
#

bundle_config '/tmp/.bundle/config' do
  values(
    'BUNDLE_MIRROR__HTTPS://RUBYGEMS__ORG/' => 'http://localhost:9292')
end
