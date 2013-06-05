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

Author:: Apache v2 (<Sean OMeara <someara@opscode.com>>)
