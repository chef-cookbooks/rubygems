#
# Cookbook:: test_rubygems
# Recipe:: default
#
# Copyright:: 2016, The Authors, All Rights Reserved.
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
