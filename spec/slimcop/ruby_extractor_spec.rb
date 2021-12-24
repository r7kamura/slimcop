# frozen_string_literal: true

RSpec.describe Slimcop::RubyExtractor do
  describe '#call' do
    subject do
      described_class.new(
        file_path: file_path,
        source: source
      ).call
    end

    let(:file_path) do
      'example.html.slim'
    end

    let(:source) do
      <<~'SLIM'
        - a
        = b
        | #{c}
      SLIM
    end

    context 'on valid case' do
      it 'extracts Ruby codes and their location from given Slim code' do
        is_expected.to eq(
          [
            { begin_: 2, code: 'a', end_: 3 },
            { begin_: 6, code: 'b', end_: 7 },
            { begin_: 12, code: 'c', end_: 13 }
          ]
        )
      end
    end

    context 'with Slim syntax error' do
      let(:source) do
        '$'
      end

      it 'raises error with expected file path' do
        expect { subject }.to raise_error(Slimi::Errors::UnknownLineIndicatorError) { |error|
          expect(error.to_s).to include(file_path)
        }
      end
    end
  end
end
