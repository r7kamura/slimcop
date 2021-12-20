# frozen_string_literal: true

module Slimcop
  # Report offenses in Slim file, and apply auto-corrections if required.
  class Runner
    # @param [String] file_path
    # @param [RuboCop::Config] rubocop_config
    def initialize(file_path:, rubocop_config:)
      @file_path = file_path
      @rubocop_config = rubocop_config
    end

    # @return [Array<Hash>]
    def call
      SlimOffenseCollector.new(
        file_path: @file_path,
        rubocop_config: @rubocop_config,
        source: source
      ).call
    end

    private

    # @return [Array<Hash>]
    def snippets
      RubyExtractor.new(source: source).call
    end

    # @return [String]
    def source
      ::File.read(@file_path)
    end
  end
end
