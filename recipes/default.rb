#
# Author:: Ryan Hass <rhass@chef.io>
# Author:: Sean OMeara <sean@sean.io>
# Cookbook Name:: rubygems
# Recipe:: default
#
# Copyright 2009-2016, Chef Software Inc.
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
gemrc "local_disable_default" do
  name :local
  values(
    sources: node["rubygems"]["gem_sources"] - %w{http://rubygems.org https://rubygems.org}
  )
  only_if { node["rubygems"]["gem_disable_default"] }
end

gemrc "local_gem_sources" do
  name :local
  values(
    sources: node["rubygems"]["gem_sources"]
  )
end

# chef_gem sources
gemrc "chef_gem_disable_default" do
  name :global
  values(
    sources: node["rubygems"]["chef_gem_sources"] - %w{http://rubygems.org https://rubygems.org}
  )
  only_if { node["rubygems"]["chef_gem_disable_default"] }
end

gemrc "chef_gem_sources" do
  name :global
  values(
    sources: node["rubygems"]["chef_gem_sources"]
  )
end
