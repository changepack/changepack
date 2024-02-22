# typed: false
# frozen_string_literal: true

# you can delete this file if you don't use Rails Test Fixtures

fixtures_dir = command_options&.fetch('fixtures_dir', nil)
fixture_files = command_options&.fetch('fixtures', nil)

if defined?(ActiveRecord)
  require 'active_record/fixtures'

  fixtures_dir ||= ActiveRecord::Tasks::DatabaseTasks.fixtures_path
  fixture_files ||= Dir["#{fixtures_dir}/**/*.yml"].pluck((fixtures_dir.size + 1)..-5)

  logger.debug "loading fixtures: { dir: #{fixtures_dir}, files: #{fixture_files} }"
  ActiveRecord::FixtureSet.reset_cache
  ActiveRecord::FixtureSet.create_fixtures(fixtures_dir, fixture_files)
  'Fixtures Done' # this gets returned
else # this else part can be removed
  logger.error 'Looks like activerecord_fixtures has to be modified to suite your need'
end
