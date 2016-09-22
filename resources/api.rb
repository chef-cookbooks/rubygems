require 'rubygems'
require 'uri'

RubygemsCookbook::Api = self

def initialize(*args, &block)
  super
  # Default host to name if user says rubygems_api "https://rubygems.org" or similar
  begin
    uri = URI(name)
    if uri.is_a?(URI::HTTP)
      host uri
    end
  rescue URI::InvalidURIError, ArgumentError
  end
end

#
# The Rubygems host the gems are stored on.  Defaults to whatever is in your
# current gem configuration. If `name` is specified as an http or https URL,
# uses that.
#
# @example
#   rubygems("https://rubygems.org")
#
# @example
#   rubygems do
#     host "https://rubygems.org"
#   end
#
property :host, URI, identity: true

#
# Your API key for rubygems.
#
# Defaults to the default rubygems API key.
#
# @example API using default API key
#     rubygems do
#       api_key 'asklrjhaerwkuht'
#       gem 'blah' do
#         owners << 'jkeiser'
#       end
#     end
#
# @example API using actual API key
#     rubygems do
#       gem 'blah' do
#         owners << 'jkeiser'
#       end
#     end
#
#
property :api_key, String

#
# The api object used to communicate with the server.
#
# @return [RubygemsCookbook::RubygemsOrgApi] The api object used to communicate with the server.
#
def api
  RubygemsCookbook::RubygemsOrgApi.new(host: host, api_key: api_key)
end

#
# Declare a rubygems_gem under this server.
#
# @example
#     rubygems_api do
#       gem "jkeiser" do
#         ...
#       end
#     end
#
def gem(name, &block)
  rubygems_api = self
  in_recipe do
    rubygems_gem name do
      rubygems_api rubygems_api
      instance_eval(&block)
    end
  end
end

#
# Declare a rubygems_user under this server.
#
# @example
#     rubygems_api do
#       user "jkeiser" do
#         ...
#       end
#     end
#
def user(name, &block)
  rubygems_api = self
  in_recipe do
    rubygems_user name do
      rubygems_api rubygems_api
      instance_eval(&block)
    end
  end
end

def in_recipe(&block)
  recipe = Chef::Recipe.new(cookbook_name, recipe_name, run_context)
  recipe.instance_eval(&block)
end

# Allow `rubygems_api do` rather than just `rubygems_api "blah" do`
module Chef::DSL::Recipe
  def rubygems_api(*args, &block)
    if args.size == 0
      super("rubygems.org", &block)
    else
      super
    end
  end
end
