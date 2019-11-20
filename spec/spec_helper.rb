require "bundler/setup"
require "next_rails"
require "next_rails/cli"
require "helpers"

RSpec.configure do |config|
  config.include NextRails::Rspec::Helpers

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
