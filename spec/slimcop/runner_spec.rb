# frozen_string_literal: true

require 'rubocop'

RSpec.describe Slimcop::Runner do
  describe '#call' do
    subject do
      described_class.new(
        file_path: 'spec/fixtures/dummy.slim',
        rubocop_config: RuboCop::ConfigLoader.default_configuration
      ).call
    end

    it do
      is_expected.to be_a(Array)
    end
  end
end
