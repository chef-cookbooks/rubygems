#
# Cookbook:: test_rubygems
# Recipe:: gemrc_global
#
# Copyright:: 2016-2017, Ryan Hass
#

gemrc :global do
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
