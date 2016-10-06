#!/usr/bin/env rake

# Style tests. chefstyle (rubocop) and Foodcritic
namespace :style do
  begin
    require "chefstyle"
    require "rubocop/rake_task"

    desc "Run ChefStyle checks"
    RuboCop::RakeTask.new(:chef) do |task|
      task.options << "--display-cop-names"
    end
  rescue LoadError => e
    puts ">>> Gem load error: #{e}, omitting style:chef" unless ENV["CI"]
  end

  begin
    require "foodcritic"

    desc "Run Foodcritic linting checks"
    FoodCritic::Rake::LintTask.new(:foodcritic) do |t|
      t.options = {
        fail_tags: ["any"],
        progress: true,
      }
    end
  rescue LoadError
    puts ">>> Gem load error: #{e}, omitting style:chef" unless ENV["CI"]
  end
end

desc "Run all style checks"
task style: %w{style:foodcritic style:chef}

# ChefSpec
begin
  require "rspec/core/rake_task"

  desc "Run ChefSpec examples"
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.rspec_opts = [].tap do |a|
      a.push("--default-path test")
      a.push("--color")
      a.push("--format doc")
    end
  end
rescue LoadError => e
  puts ">>> Gem load error: #{e}, omitting spec" unless ENV["CI"]
end

# Integration tests. Kitchen.ci
namespace :integration do
  begin
    require "kitchen/rake_tasks"

    desc "Run kitchen integration tests"
    Kitchen::RakeTasks.new
  rescue StandardError => e
    puts ">>> Kitchen error: #{e}, omitting #{task.name}" unless ENV["CI"]
  end
end

namespace :supermarket do
  begin
    require "stove/rake_task"

    desc "Publish cookbook to Supermarket with Stove"
    Stove::RakeTask.new
  rescue LoadError => e
    puts ">>> Gem load error: #{e}, omitting #{task.name}" unless ENV["CI"]
  end
end

# Default
task default: %w{style spec}
