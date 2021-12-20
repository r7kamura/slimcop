# frozen_string_literal: true

require 'rubocop'

RSpec.describe Slimcop::Runner do
  let(:runner) do
    described_class.new(
      file_path: 'spec/fixtures/dummy.slim',
      rubocop_config: RuboCop::ConfigLoader.default_configuration
    )
  end

  describe '#auto_correct' do
    subject do
      runner.auto_correct
    end

    it do
      skip # TODO
    end
  end

  describe '#offenses' do
    subject do
      runner.offenses
    end

    it do
      is_expected.to be_a(Array)
    end
  end
end
