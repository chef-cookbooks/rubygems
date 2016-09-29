name             "rubygems"
maintainer       "Ryan Hass"
maintainer_email "Ryan Hass <rhass+community-cookbooks@chef.io>"
license          "apachev2"
description      "Configures rubygems and bundler"
long_description IO.read(File.join(File.dirname(__FILE__), "README.md"))
version          "0.4.0"

issues_url "https://github.com/chef-cookbooks/rubygems/issues" if respond_to?(:issues_url)
source_url "https://github.com/chef-cookbooks/rubygems" if respond_to?(:source_url)

chef_version ">= 12.8.1"
