#
# Cookbook Name:: test_rubygems
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#

file File.join(Dir.home, ".gemrc") do
  content({
    backtrace: false,
    bulk_threshold: 1000,
    sources: %w{
       http://localhost:9292
    },
    verbose: true,
    install: "--user --no-document",
    update: "--user --no-document",
  }.to_yaml)
end

gemrc :local do
  values(
    sources: %w{https://rubygems.org}
  )
end
