require 'yaml'

resource_name :bundle_config

property :path, String, name_property: true
property :user, String, default: lazy { ENV['USERNAME'] || ENV['USER'] }
property :group, String, default: lazy { ENV['USERNAME'] || ENV['USER'] }
property :values, Hash

load_current_value do
  current_value_does_not_exist! unless ::File.exist?(path)
  values YAML.load_file(path)
  user 
end

action :create do
  if current_resource
    desired_values = current_resource.values.merge(values)
  else
    desired_values = values
  end

  directory ::File.dirname(path) do
    user new_resource.user
    group new_resource.group
    recursive true
  end

  file path do
    user new_resource.user
    content YAML.dump(desired_values)
  end
end
