#
# Author:: Sean OMeara <someara@opscode.com>
# Cookbook Name:: rubygems
# Recipe:: default
#
# Copyright 2009-2013, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# gem_package sources
if node['rubygems']['gem_disable_default'] then
  execute "gem sources --remove http://rubygems.org" do
    only_if "gem sources --list | grep 'http://rubygems.org'"
  end.run_action(:run)
end

node['rubygems']['gem_sources'].each do |source|
  execute "gem sources --add #{source}" do
    not_if "gem sources --list | grep '#{source}'"
  end.run_action(:run)
end

# chef_gem sources
if node['rubygems']['chef_gem_disable_default'] then
  execute "/opt/chef/embedded/bin/gem sources --remove http://rubygems.org/" do
    only_if "gem sources --list | grep 'http://rubygems.org'"
  end.run_action(:run)
end

node['rubygems']['chef_gem_sources'].each do |source|
  execute "/opt/chef/embedded/bin/gem sources --add #{source}" do
    not_if "gem sources --list | grep '#{source}'"
  end.run_action(:run)
end
