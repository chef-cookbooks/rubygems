#
# Cookbook:: test_rubygems
# Recipe:: gemrc_local
#
# Copyright:: 2016-2017, Ryan Hass
#

gemrc :local do
  values(
    backtrace: false,
    bulk_threshold: 1000,
    sources: %w(
      http://localhost:9292
    ),
    verbose: true,
    install: '--user --no-document',
    update: '--user --no-document'
  )
end
