# rubygems Cookbook CHANGELOG

This file is used to list changes made in each version of the rubygems cookbook.

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
