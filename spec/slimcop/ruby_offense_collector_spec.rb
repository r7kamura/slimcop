# frozen_string_literal: true

require 'rubocop'

RSpec.describe Slimcop::RubyOffenseCollector do
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
      <<~RUBY
        "a"
      RUBY
    end

    context 'with valid condition' do
      it 'collects offenses from given Ruby code' do
        is_expected.to be_a(Array)
        expect(subject).not_to be_empty
      end
    end

    context 'with rubocop:todo comment' do
      let(:source) do
        <<~RUBY
          "a" \# rubocop:todo Style/StringLiterals
        RUBY
      end

      it 'excludes disabled offenses' do
        is_expected.to be_a(Array)
        expect(subject).to be_empty
      end
    end

    context 'with rubocop:disable comment' do
      let(:source) do
        <<~RUBY
          "a" \# rubocop:disable Style/StringLiterals
        RUBY
      end

      it 'excludes disabled offenses' do
        is_expected.to be_a(Array)
        expect(subject).to be_empty
      end
    end
  end
end
