#
# Cookbook:: test_rubygems
# Recipe:: default
#
# Copyright:: 2016, The Authors, All Rights Reserved.
#

bundle_config '/tmp/.bundle/config' do
  values(
    'BUNDLE_MIRROR__HTTPS://RUBYGEMS__ORG/' => 'http://localhost:9292')
end
