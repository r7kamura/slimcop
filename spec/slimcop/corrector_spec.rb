# frozen_string_literal: true

require 'rubocop'

RSpec.describe Slimcop::Corrector do
  describe '#call' do
    subject do
      described_class.new(
        file_path: file_path,
        offenses: offenses,
        source: source
      ).call
    end

    let(:file_path) do
      'spec/fixtures/dummy.slim'
    end

    let(:offenses) do
      Slimcop::Runner.new(
        file_path: file_path,
        rubocop_config: RuboCop::ConfigLoader.default_configuration,
      ).call
    end

    let(:source) do
      File.read(file_path)
    end

    it do
      puts subject
    end
  end
end
