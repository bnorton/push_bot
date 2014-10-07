require 'push_bot'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.profile_examples = 1

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end
end
