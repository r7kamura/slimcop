# frozen_string_literal: true

RSpec.describe Slimcop::SlimOffenseCollector do
  describe '#call' do
    subject do
      described_class.new(
        auto_correct: false,
        file_path: 'dummy.slim',
        rubocop_config: Slimcop::RuboCopConfigGenerator.new.call,
        source: source
      ).call
    end

    let(:source) do
      raise NotImplementedError
    end

    context 'with no offense' do
      let(:source) do
        <<~SLIM
          - a
        SLIM
      end

      it 'returns expected offenses' do
        expect(subject).to be_empty
      end
    end

    context 'with offense' do
      let(:source) do
        <<~SLIM
          - "a"
        SLIM
      end

      it 'returns expected offenses' do
        expect(subject).not_to be_empty
      end
    end

    context 'with offense in Ruby attribute' do
      let(:source) do
        <<~SLIM
          div a=("b")
        SLIM
      end

      it 'returns expected offenses' do
        expect(subject).not_to be_empty
      end
    end

    context 'with offense in if' do
      let(:source) do
        <<~SLIM
          - if "a"
        SLIM
      end

      it 'returns expected offenses' do
        expect(subject).not_to be_empty
      end
    end

    context 'with offense and do' do
      let(:source) do
        <<~SLIM
          - a("b") do
        SLIM
      end

      it 'returns expected offenses' do
        expect(subject).not_to be_empty
      end
    end
  end
end
