# frozen_string_literal: true

RSpec.describe Slimcop::SlimCorrector do
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
      Slimcop::SlimOffenseCollector.new(
        auto_correct: false,
        file_path: file_path,
        rubocop_config: rubocop_config,
        source: source
      ).call
    end

    let(:rubocop_config) do
      Slimcop::RuboCopConfigGenerator.new.call
    end

    let(:source) do
      File.read(file_path)
    end

    it do
      subject
    end
  end
end
