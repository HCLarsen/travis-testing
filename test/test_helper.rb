puts "Rails: #{rails_version = ENV["RAILS_VERSION"]}"

if rails_version >= "5"
  require File.expand_path("../../test/dummy5/config/environment.rb", __FILE__)
  ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy5/db/migrate", __FILE__)]
else
  require File.expand_path("../../test/dummy4/config/environment.rb", __FILE__)
  ActiveRecord::Migrator.migrations_paths = [File.expand_path("../../test/dummy4/db/migrate", __FILE__)]  
end
require "rails/test_help"

# Filter out Minitest backtrace while allowing backtrace from other libraries
# to be shown.
Minitest.backtrace_filter = Minitest::BacktraceFilter.new

Rails::TestUnitReporter.executable = 'bin/test'

# Load fixtures from the engine
if ActiveSupport::TestCase.respond_to?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
  ActionDispatch::IntegrationTest.fixture_path = ActiveSupport::TestCase.fixture_path
  ActiveSupport::TestCase.file_fixture_path = ActiveSupport::TestCase.fixture_path + "/files"
  ActiveSupport::TestCase.fixtures :all
end
