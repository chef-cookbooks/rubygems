require "set"

#
# The name of the gem. Defaults to the name of the resource.
#
property :gem_name, String, name_property: true, identity: true

#
# The rubygems_api resource used to communicate with the server.
#
property :rubygems_api, RubygemsCookbook::Api, identity: true, default: lazy { RubygemsCookbook::Api.new("rubygems.org", run_context) }

#
# The list of owners.
#
# Defaults to the *current* list of owners, so that << will work. If you want to
# limit the list of owners, use `owners []`.
#
property :owners, Set,
  # Start out with current owners
  default: lazy { current_value.owners },
  coerce: proc { |value| value.to_set }

#
# `true` to remove owners from the gem who are not in `owners`.
#
# Defaults to false.
#
property :purge, [true, false], default: false, desired_state: false

#
# Load owners from /api/v1/gems/GEM/owners.json
#
load_current_value do
  owners rubygems_api.api.get("api/v1/gems/#{gem_name}/owners.json").map { |owner| owner["handle"] || owner["email"] }
end

action :create do
  if new_resource.property_is_set?(:owners)
    current_owners = current_resource.owners
    desired_owners = new_resource.owners

    #
    # Add new owners
    #
    (desired_owners - current_owners).each do |add_owner|
      converge_by "add #{add_owner} as owner of #{gem_name}" do
        rubygems_api.api.post("api/v1/gems/#{gem_name}/owners", email: add_owner)
      end
    end

    #
    # Remove missing owners
    #
    (current_owners - desired_owners).each do |remove_owner|
      if purge
        converge_by "remove #{remove_owner} from ownership of #{gem_name}" do
          rubygems_api.api.delete("api/v1/gems/#{gem_name}/owners", email: remove_owner)
        end
      else
        converge_by "would remove #{remove_owner} from ownership of #{gem_name}, but purge is off" do
        end
      end
    end
  end
end

# sadness :(
action_class do
  def whyrun_supported?
    true
  end
end
