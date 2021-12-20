# frozen_string_literal: true

require 'rubocop'

RSpec.describe Slimcop::OffenseCollector do
  describe '#call' do
    subject do
      described_class.new(
        file_path: 'dummy.slim',
        rubocop_config: RuboCop::ConfigLoader.default_configuration,
        ruby_code: 'dummy'
      ).call
    end

    it do
      is_expected.to be_a(RuboCop::Cop::Commissioner::InvestigationReport)
    end
  end
end
