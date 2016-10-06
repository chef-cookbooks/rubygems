#
# Cookbook Name:: test_rubygems
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#

bundle_config "/tmp/.bundle/config" do
  values(
    # rubocop:disable Style/StringLiterals
    { 'BUNDLE_MIRROR__HTTPS://RUBYGEMS__ORG/' => 'http://localhost:9292' } )
end
