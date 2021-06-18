#
# Author:: Ryan Hass <rhass@chef.io>
# Author:: John Keiser <jkeiser@chef.io>
# Cookbook:: rubygems
# Resource:: bundle_config
#
# Copyright:: 2016-2019, Chef Software Inc.
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

require 'yaml'

provides :bundle_config
unified_mode true

property :path, String, name_property: true
property :user, String
property :group, String
property :values, Hash

load_current_value do
  current_value_does_not_exist! unless ::File.exist?(path)
  values YAML.load_file(path)
end

action :create do
  desired_values = if current_resource
                     current_resource.values.merge(new_resource.values)
                   else
                     new_resource.values
                   end

  directory ::File.dirname(new_resource.path) do
    user new_resource.user if new_resource.property_is_set?(:user)
    group new_resource.group if new_resource.property_is_set?(:group)
    recursive true
  end

  file new_resource.path do
    user new_resource.user if new_resource.property_is_set?(:user)
    group new_resource.group if new_resource.property_is_set?(:group)
    content YAML.dump(desired_values)
  end
end
