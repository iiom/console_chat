require 'rspec'
require 'active_record'
require 'sqlite3'
require_relative '../lib/DBConnection'
require_relative '../lib/models/user'
require_relative '../lib/models/message'
require_relative '../lib/models/messages_user'
require_relative '../lib/controller/session_controller'
require_relative '../lib/controller/message_controller'

yml = File.join(File.expand_path(Dir.pwd),  'db', 'config.yml')
DBConnection.db_configuration(yml, "test")
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.before(:all) do
    %x[bundle exec rake db:drop]
    %x[bundle exec rake db:schema:load RAILS_ENV=test]
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
