# frozen_string_literal: true

RSpec.describe Slimcop::RubyExtractor do
  describe '#call' do
    subject do
      described_class.new(
        source: source
      ).call
    end

    let(:source) do
      <<~'SLIM'
        - a
        = b
        | #{c}
      SLIM
    end

    it do
      is_expected.to eq(
        [
          { begin_: 2, code: 'a', end_: 3 },
          { begin_: 6, code: 'b', end_: 7 },
          { begin_: 12, code: 'c', end_: 13 }
        ]
      )
    end
  end
end
