# frozen_string_literal: true

require 'rubocop'

RSpec.describe Slimcop::Corrector do
  describe '#call' do
    subject do
      offenses = Slimcop::Runner.new(
        file_path: 'spec/fixtures/dummy.slim',
        rubocop_config: RuboCop::ConfigLoader.default_configuration
      ).call

      described_class.new(
        file_path: 'spec/fixtures/dummy.slim',
        offenses: offenses
      ).call
    end

    it do
      puts subject
    end
  end
end
