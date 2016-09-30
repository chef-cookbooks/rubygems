#
# Author:: John Keiser <jkeiser@chef.io>
# Cookbook Name:: rubygems
# Livrary:: RubygemsOrgApi
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

require "rubygems/command"
require "rubygems/gemcutter_utilities"
require "json"

module ::RubygemsCookbook
  #
  # Talk to the https://rubygems.org API.
  #
  class RubygemsOrgApi
    include Gem::GemcutterUtilities

    def initialize(host: nil, allowed_push_host: nil, api_key: nil)
      self.host = host if host
      @allowed_push_host = allowed_push_host
      @options = {}
      @options[:api_key] = api_key if api_key
    end

    #
    # The host we are allowed to push to.
    #
    attr_reader :allowed_push_host

    #
    # Options for the request (api_key = )
    #
    attr_reader :options

    #
    # Make a request to the API
    #
    def request(method, path, params: nil)
      uri = URI.join(host, path)
      if method == :get
        Chef::Log.debug("Hitting #{method.to_s.upcase} #{uri}.")
      else
        Chef::Log.info("Hitting #{method.to_s.upcase} #{uri}.  API key: #{api_key}")
      end
      begin
        response = rubygems_api_request(method, path, host, allowed_push_host) do |request|
          request.add_field("Authorization", api_key) if api_key
          if params
            params = params.inject({}) { |h, (key, value)| h[key.to_s] = value.to_s; h }
            Chef::Log.debug("Form parameters: #{params.map { |key, value| "#{key}=#{value}" }.join(', ')}")
            request.set_form_data(params)
          end
        end
        response.value
      rescue Net::HTTPExceptions => e
        Chef::Log.error("Failed to #{method} #{uri}: #{response}.  Body:")
        Chef::Log.debug(response.body)
        # Create an actually INTELLIGIBLE error message.
        new_exception = e.class.new("#{$!.message} from #{method.to_s.upcase} #{uri}", e.response)
        new_exception.set_backtrace(e.backtrace)
        raise new_exception
      end
      Chef::Log.debug("Successfully hit #{method} #{uri}. Body:")
      Chef::Log.debug(response.body)
      response.body
    end

    def get_raw(path, **params)
      # Add query parameters (GET does not do form post)
      if params && !params.empty?
        path = "#{path}?#{params.map { |k, v| "#{CGI.escape(k)}=#{CGI.escape(v)}" }.join(';')}"
      end
      request(:get, path)
    end

    def get(path, **params)
      JSON.parse(get_raw(path, **params))
    end

    def put(path, **params)
      request(:put, path, params: params)
    end

    def post(path, **params)
      request(:post, path, params: params)
    end

    def delete(path, **params)
      request(:delete, path, params: params)
    end
  end
end
