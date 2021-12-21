# frozen_string_literal: true

require 'rubocop'

RSpec.describe Slimcop::RubyOffenseCollector do
  describe '#call' do
    subject do
      described_class.new(
        file_path: 'dummy.slim',
        rubocop_config: RuboCop::ConfigLoader.default_configuration,
        source: 'dummy'
      ).call
    end

    it 'collects offenses from given Ruby code' do
      is_expected.to be_a(Array)
    end
  end
end
