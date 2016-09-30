[![Build Status](https://travis-ci.org/chef-cookbooks/rubygems.svg?branch=master)](https://travis-ci.org/chef-cookbooks/rubygems)
[![Cookbook Version](https://img.shields.io/cookbook/v/rubygems.svg)](https://supermarket.chef.io/cookbooks/rubygems)
[![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

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

Resources
=========
This cookbook provides two simple resources which allow you to set any
key/value configuration for the gemrc or bundle config files.

gemrc
-----
Configures the gemrc.

### Attributes
 - `path`   - Accepts sybols `:global`, `:local`, or a string litteral path to
              the `.gemrc` file. _Default: Name of Resource Instance_
 - `user`   - Owner of gemrc file.
 - `group`  - Group associated to gemrc file.
 - `values` - Hash containing all key/values to configure.

### Action
 - `:create` - _Default Action_

### Usage
Global configuration usage:
```ruby
gemrc :global do
  values(
    sources: %w{ http://localhost:9292 https://rubygems.org }
  )
end
```
 
 
Litteral path usage:

```ruby
gemrc '/path/to/.gemrc' do
  values(
    sources: %w{ http://localhost:9292 https://rubygems.org }
  )
end
```


bundle_config
-------------
Configures bundler.

### Attributes
 - `path`   - A litteral path to the `.gemrc` file. _Default: Name of Resource Instance_
 - `user`   - Owner of gemrc file.
 - `group`  - Group associated to gemrc file.
 - `values` - Hash containing all key/values to configure.

### Action
 - `:create` - _Default Action_

### Usage
```ruby
bundle_config '/path/to/.bundle/config' do
  values(
    { 'BUNDLE_MIRROR__HTTPS://RUBYGEMS__ORG/' => 'http://localhost:9292' }
  )
end
```

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

License and Authors
===================
Author:: Sean OMeara (<sean@sean.io>)
Author:: John Keiser (<jkeiser@chef.io>)
Author:: Ryan Hass (<rhass@chef.io>)
