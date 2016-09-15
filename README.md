Description
===========

This cookbook configured "system" and Omnibus Chef gem sources.

Requirements
============
Omnibus Chef 11 or above

Usage
=====

From a Vagrantfile, role, or environment definition, set something
like this, to point at a privately hosted rubygems mirror:

    :rubygems => {
      :gem_disable_default => true,
      :gem_sources => [],
      :chef_gem_disable_default => true,
      :chef_gem_sources => [ 'http://33.33.33.51/rubygems/' ]
    },

Attributes
==========

    # From attributes/default.rb
    default['rubygems']['gem_disable_default'] = false
    default['rubygems']['gem_sources'] = [ 'https://rubygems.org' ]
    default['rubygems']['chef_gem_disable_default'] = false
    default['rubygems']['chef_gem_sources'] = [ 'https://rubygems.org' ]

Recipes
=======

default

Resources
=========

This cookbook provides the `rubygems_api` resource, which lets you manage ownership
of gems on [rubygems.org](https://rubygems.org). To do so, you can do this:

```ruby
rubygems_api do
  gem "chef" do
    owners << "jkeiser"
  end
end
```

Or this:

```ruby
rubygems_api do
  user "jkeiser" do
    owned_gems << "chef"
  end
end
```

If you want to set `owners` or `owned_gems` to a specific set of users and have it
remove all others, you can add `purge true` to either `user` or `gem` resource.

To talk to a custom gem server, you can say `rubygems_api "https://otherserver.com" do ... end`.
You can also modify the API key you are by specifying the `api_key` property under `rubygems_api`.

Author:: Apache v2 (<Sean OMeara <someara@opscode.com>>)
