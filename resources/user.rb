require 'set'

#
#
#
property :handle, String, identity: true, default: lazy { name }
property :rubygems_api, RubygemsCookbook::Api, identity: true, default: lazy { RubygemsCookbook::Api.new("rubygems.org") }

#
# The set of gems this user owns.
#
property :owned_gems, Set,
  # Start out with current ownership
  default: lazy { current_value.owned_gems },
  coerce: proc { |value| value.to_set }

  #
  # `true` to remove the user's gem ownership from any gems not specified in `owned_gems`.
  #
  # Defaults to false.
  #
property :purge, [true,false], default: false, desired_state: false

load_current_value do
  #
  # Grab the current set of owned gems from /api/v1/owners/USERNAME/gems.json.
  #
  gem_owners rubygems.api.get("api/v1/owners/#{handle}/gems.json", log).map { |_gem| _gem['name'] }
end

action :create do
  #
  # Modify the user's owned_gems (if different)
  #
  if new_resource.property_is_set?(:owned_gems)
    current_gems = current_resource.owned_gems
    desired_gems = new_resource.owned_gems

    #
    # Add new owners
    #
    (desired_gems - current_gems).each do |add_gem|
      converge_by "add #{handle} as owner of #{add_gem}" do
        rubygems_api.api.post("api/v1/gems/#{add_gem}/owners", email: handle)
      end
    end

    #
    # Remove missing owners
    #
    (current_gems - desired_gems).each do |remove_gem|
      if purge
        converge_by "remove #{handle} from ownership of #{remove_gem}" do
          rubygems_api.api.delete("api/v1/gems/#{remove_gem}/owners", email: handle)
        end
      else
        Chef::Log.info "would remove #{handle} from ownership of #{add_gem}, but purge is off"
      end
    end
  end
end
