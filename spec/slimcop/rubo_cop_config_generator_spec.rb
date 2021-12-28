# frozen_string_literal: true

RSpec.describe Slimcop::RuboCopConfigGenerator do
  describe '#call' do
    subject do
      described_class.new(
        additional_config_file_path: additional_config_file_path
      ).call
    end

    let(:additional_config_file_path) do
      nil
    end

    context 'with valid condition' do
      it do
        is_expected.to be_a(RuboCop::Config)
      end
    end

    context 'with existent additional_config_file_path' do
      let(:additional_config_file_path) do
        '.rubocop.yml'
      end

      it do
        is_expected.to be_a(RuboCop::Config)
      end
    end

    context 'with non-existent additional_config_file_path' do
      let(:additional_config_file_path) do
        'non_existent.yml'
      end

      it do
        expect { subject }.to raise_error(RuboCop::ConfigNotFoundError)
      end
    end
  end
end
