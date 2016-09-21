require 'yaml'

resource_name :gemrc

property :path, String, name_property: true, coerce: proc { |path| coerce_path(path) }
property :user, String, default: lazy { ENV['USERNAME'] || ENV['USER'] }
property :group, String, default: lazy { ENV['USERNAME'] || ENV['USER'] }
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
    recursive true
  end

  file path do
    content YAML.dump(desired_values)
  end
end

private

def coerce_path(value)
  case value
  when :local
    "~/.gemrc"
  when :global
    Gem::ConfigFile::SYSTEM_WIDE_CONFIG_FILE
  else
    value
  end
end

