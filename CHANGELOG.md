# rubygems Cookbook CHANGELOG

This file is used to list changes made in each version of the rubygems cookbook.

## Unreleased

- resolved cookstyle error: resources/bundle_config.rb:1:1 refactor: `Chef/Deprecations/ResourceWithoutUnifiedTrue`
- resolved cookstyle error: resources/gemrc.rb:1:1 refactor: `Chef/Deprecations/ResourceWithoutUnifiedTrue`

## 1.2.0 (2020-06-02)

- Update the platforms we test on - [@tas50](https://github.com/tas50)
- Add code owners file - [@tas50](https://github.com/tas50)
- Rename the kitchen config - [@tas50](https://github.com/tas50)
- Cookstyle fixes - [@tas50](https://github.com/tas50)
- Resolve cookstyle 5.8 warnings - [@tas50](https://github.com/tas50)
- Require Chef 12.15+ - [@tas50](https://github.com/tas50)
- Lint/SuppressedException - [@Xorima](https://github.com/Xorima)
- Use the org wide GitHub templates - [@tas50](https://github.com/tas50)
- Update ChefSpec platforms - [@tas50](https://github.com/tas50)
- Chef Infra Client 16 compatibility fixes - [@Xorima](https://github.com/Xorima)
  - resolved cookstyle error: resources/bundle_config.rb:25:1 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`
  - resolved cookstyle error: resources/gemrc.rb:26:1 warning: `ChefDeprecations/ResourceUsesOnlyResourceName`

## 1.1.1 (2018-03-07)

- Resolve Chef 14 incompatibilies

## 1.1.0 (2017-05-30)

- Remove class_eval usage and require Chef 12.7+

## 1.0.4 (2017-04-17)

- Use kitchen-dokken for integration testing in Travis and switch to delivery local for testing instead of the Rakefile
- Prevent failures with metadata.rb on older chef clients
- Ensure compatibility with Chef 12.5/12.6
- Remove invalid supports metadata

## 1.0.3 (2017-02-13)

- Fix gemrc error if sources is an array.
- Update ignore files
- Add maintainers files
- Add the full Apache license file
