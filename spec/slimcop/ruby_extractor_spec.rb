# frozen_string_literal: true

RSpec.describe Slimcop::RubyExtractor do
  describe '.call' do
    subject do
      described_class.call(
        file_path: file_path,
        source: source
      )
    end

    let(:file_path) do
      'dummy.slim'
    end

    let(:source) do
      <<~SLIM
        a
        = b
        - array.each do |element|
          = element
      SLIM
    end

    context 'with valid condition' do
      it 'returns an Array of positional code data' do
        is_expected.to eq(
          [
            {
              code: 'b',
              offset: 4
            },
            {
              code: 'array.each',
              offset: 8
            },
            {
              code: 'element',
              offset: 36
            }
          ]
        )
      end
    end
  end
end
