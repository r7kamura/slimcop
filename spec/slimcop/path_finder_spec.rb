# frozen_string_literal: true

RSpec.describe Slimcop::PathFinder do
  describe '#call' do
    subject do
      described_class.new(
        patterns: patterns
      ).call
    end

    let(:patterns) do
      raise NotImplementedError
    end

    context 'with normal file path' do
      let(:patterns) do
        %w[spec/fixtures/dummy.slim]
      end

      it 'returns expected file paths' do
        is_expected.to eq(patterns)
      end
    end

    context 'with glob pattern' do
      let(:patterns) do
        %w[spec/**/*.slim]
      end

      it 'returns expected file paths' do
        is_expected.to eq(%w[spec/fixtures/dummy.slim])
      end
    end

    context 'with directory path' do
      let(:patterns) do
        %w[spec/fixtures]
      end

      it 'excludes directies' do
        is_expected.to be_empty
      end
    end
  end
end
