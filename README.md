# Rubygems Cookbook

[![Build Status](https://travis-ci.org/chef-cookbooks/rubygems.svg?branch=master)](https://travis-ci.org/chef-cookbooks/rubygems) [![Cookbook Version](https://img.shields.io/cookbook/v/rubygems.svg)](https://supermarket.chef.io/cookbooks/rubygems) [![License](https://img.shields.io/badge/license-Apache_2-blue.svg)](https://www.apache.org/licenses/LICENSE-2.0)

This cookbook configures "system" and Omnibus Chef gem sources, as well as providing the `rubygems_api` resource, which lets you manage ownership of gems on [rubygems.org](https://rubygems.org).

## Requirements

### Chef

- 12.7 or later

## Usage

There are two ways to use this cookbook. The legacy way is to set the desired attributes and simply `include_recipe 'rubygems'`. The modern and recommended way is to call the `gemrc` and/or `bundle_config` resources as shown in the [Resources](#resources) section below.

## Attributes

```
# From attributes/default.rb
default['rubygems']['gem_disable_default'] = false
default['rubygems']['gem_sources'] = [ 'https://rubygems.org' ]
default['rubygems']['chef_gem_disable_default'] = false
default['rubygems']['chef_gem_sources'] = [ 'https://rubygems.org' ]
```

## Resources

This cookbook provides two simple resources which allow you to set any key/value configuration for the gemrc or bundle config files. Additionaly this cookbook provides the `rubygems_api` resource, which lets you manage ownership of gems on [rubygems.org](https://rubygems.org).

### rubygems_api

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

If you want to set `owners` or `owned_gems` to a specific set of users and have it remove all others, you can add `purge true` to either `user` or `gem` resource.

To talk to a custom gem server, you can say `rubygems_api "https://otherserver.com" do ... end`. You can also modify the API key you are by specifying the `api_key` property under `rubygems_api`.

### gemrc

Configures the gemrc.

#### Properties

- `path` - Accepts symbols `:global`, `:local`, or a string literal path to the `.gemrc` file. _Default: Name of Resource Instance_
- `user` - Owner of gemrc file.
- `group` - Group associated to gemrc file.
- `values` - Hash containing all key/values to configure.

#### Action

- `:create` - _Default Action_

#### Usage

Global configuration usage:

```ruby
gemrc :global do
  values(
    sources: %w{ http://localhost:9292 https://rubygems.org }
  )
end
```

Literal path usage:

```ruby
gemrc '/path/to/.gemrc' do
  values(
    sources: %w{ http://localhost:9292 https://rubygems.org }
  )
end
```

### bundle_config

Configures bundler.

#### Properties

- `path` - A literal path to the `.gemrc` file. _Default: Name of Resource Instance_
- `user` - Owner of gemrc file.
- `group` - Group associated to gemrc file.
- `values` - Hash containing all key/values to configure.

#### Action

- `:create` - _Default Action_

#### Usage

```ruby
bundle_config '/path/to/.bundle/config' do
  values(
    { 'BUNDLE_MIRROR__HTTPS://RUBYGEMS__ORG/' => 'http://localhost:9292' }
  )
end
```

## License and Authors

- Author:: Sean OMeara ([sean@sean.io](mailto:sean@sean.io))
- Author:: John Keiser ([jkeiser@chef.io](mailto:jkeiser@chef.io))
- Author:: Ryan Hass ([rhass@chef.io](mailto:rhass@chef.io))

Copyright (c) 2009-2016, Chef Software Inc.

```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
