name             "rubygems"
maintainer       "Apache v2"
maintainer_email "Sean OMeara <someara@opscode.com>"
license          "Apache2"
description      "Installs/Configures rubygems"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.4.0"

issues_url 'https://github.com/chef-cookbooks/rubygems/issues' if respond_to?(:issues_url)
source_url 'https://github.com/chef-cookbooks/rubygems' if respond_to?(:source_url)

chef_version '>= 12.8.1'
