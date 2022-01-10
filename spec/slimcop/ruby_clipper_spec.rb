# frozen_string_literal: true

RSpec.describe Slimcop::RubyClipper do
  describe '#call' do
    subject do
      described_class.new(code).call
    end

    let(:code) do
      'a'
    end

    context 'with valid condition' do
      it 'returns expected code and offset' do
        is_expected.to eq(
          code: 'a',
          offset: 0
        )
      end
    end

    context 'with if' do
      let(:code) do
        'if a'
      end

      it 'returns expected code and offset' do
        is_expected.to eq(
          code: 'a',
          offset: 3
        )
      end
    end

    context 'with if and an extra space' do
      let(:code) do
        'if  a'
      end

      it 'returns expected code and offset' do
        is_expected.to eq(
          code: ' a',
          offset: 3
        )
      end
    end

    context 'with for-in' do
      let(:code) do
        'for i in 1..10'
      end

      it 'returns expected code and offset' do
        is_expected.to eq(
          code: '1..10',
          offset: 9
        )
      end
    end

    context 'with do' do
      let(:code) do
        'a do'
      end

      it 'returns expected code and offset' do
        is_expected.to eq(
          code: 'a',
          offset: 0
        )
      end
    end

    context 'with do and extra space' do
      let(:code) do
        'a do '
      end

      it 'returns expected code and offset' do
        is_expected.to eq(
          code: 'a',
          offset: 0
        )
      end
    end

    context 'with do |x|' do
      let(:code) do
        'a do |x|'
      end

      it 'returns expected code and offset' do
        is_expected.to eq(
          code: 'a',
          offset: 0
        )
      end
    end

    context 'with do |x| and extra space' do
      let(:code) do
        'a do |x| '
      end

      it 'returns expected code and offset' do
        is_expected.to eq(
          code: 'a',
          offset: 0
        )
      end
    end

    context 'with do |x, y|' do
      let(:code) do
        'a do |x, y|'
      end

      it 'returns expected code and offset' do
        is_expected.to eq(
          code: 'a',
          offset: 0
        )
      end
    end

    context 'with do |(x, y)|' do
      let(:code) do
        'a do |(x, y)|'
      end

      it 'returns expected code and offset' do
        is_expected.to eq(
          code: 'a',
          offset: 0
        )
      end
    end

    context 'with if and do' do
      let(:code) do
        'if a do'
      end

      it 'returns expected code and offset' do
        is_expected.to eq(
          code: 'a',
          offset: 3
        )
      end
    end
  end
end
