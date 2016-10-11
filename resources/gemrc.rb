#
# Author:: Ryan Hass <rhass@chef.io>
# Author:: John Keiser <jkeiser@chef.io>
# Cookbook Name:: rubygems
# Resource:: gemrc
#
# Copyright 2016, Chef Software Inc.
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

require "yaml"
include Chef::Mixin::DeepMerge

resource_name :gemrc

property :path, String, name_property: true, coerce: proc { |path| coerce_path(path) }
property :user, String
property :group, String
property :values, Hash

load_current_value do
  current_value_does_not_exist! unless ::File.exist?(path)
  values YAML.load_file(path)
end

action :create do
  if current_resource
    desired_values = current_resource.values.merge(values)
  else
    desired_values = values
  end

  directory ::File.dirname(path) do
    user new_resource.user if new_resource.property_is_set?("user")
    group new_resource.group if new_resource.property_is_set?("group")
    recursive true
    not_if { new_resource.name.to_sym == :local }
  end

  file path do
    user new_resource.user if new_resource.property_is_set?("user")
    group new_resource.group if new_resource.property_is_set?("group")
    content YAML.dump(desired_values)
  end
end

private

def coerce_path(value)
  case value.to_sym
  when :local
    ::File.join(Dir.home, ".gemrc")
  when :global
    Gem::ConfigFile::SYSTEM_WIDE_CONFIG_FILE
  else
    value
  end
end
