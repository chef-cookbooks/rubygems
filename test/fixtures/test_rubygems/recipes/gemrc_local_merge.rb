#
# Cookbook:: test_rubygems
# Recipe:: gemrc_local_merge
#
# Copyright:: 2016-2017, Ryan Hass
#

file File.join(Dir.home, '.gemrc') do
  content(YAML.dump({
    backtrace: false,
    bulk_threshold: 1000,
    sources: %w(
      http://localhost:9292
    ),
    verbose: true,
    install: '--user --no-document',
    update: '--user --no-document',
  }))
end

gemrc :local do
  values(
    sources: %w(https://rubygems.org)
  )
end
