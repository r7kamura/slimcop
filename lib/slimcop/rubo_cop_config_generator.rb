# frozen_string_literal: true

require 'rubocop'

module Slimcop
  class RuboCopConfigGenerator
    # @param [String] additional_config_file_path
    def initialize(additional_config_file_path: nil)
      @additional_config_file_path = additional_config_file_path
    end

    # @return [RuboCop::Config]
    def call
      ::RuboCop::ConfigLoader.merge_with_default(merged_config, loaded_path)
    end

    private

    # @return [String]
    def loaded_path
      @additional_config_file_path || slimcop_default_config_file_path
    end

    # @return [RuboCop::Config]
    def merged_config
      ::RuboCop::Config.create(merged_config_hash, loaded_path)
    end

    # @return [Hash]
    def merged_config_hash
      result = slimcop_default_config
      result = ::RuboCop::ConfigLoader.merge(result, additional_config) if @additional_config_file_path
      result
    end

    # @return [RuboCop::Config, nil]
    def additional_config
      ::RuboCop::ConfigLoader.load_file(@additional_config_file_path) if @additional_config_file_path
    end

    # @return [RuboCop::Config]
    def slimcop_default_config
      ::RuboCop::ConfigLoader.load_file(slimcop_default_config_file_path)
    end

    # @return [String]
    def slimcop_default_config_file_path
      @slimcop_default_config_file_path ||= ::File.expand_path('../../default.yml', __dir__)
    end
  end
end
