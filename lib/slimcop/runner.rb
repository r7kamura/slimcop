# frozen_string_literal: true

module Slimcop
  class Runner
    # @param [String] file_path
    # @param [RuboCop::Config] rubocop_config
    def initialize(file_path:, rubocop_config:)
      @file_path = file_path
      @rubocop_config = rubocop_config
    end

    # @return [Array]
    def call
      snippets.flat_map do |snippet|
        Investigate.new(
          file_path: @file_path,
          rubocop_config: @rubocop_config,
          ruby_code: snippet[:code]
        ).call.offenses
      end
    end

    private

    # @return [Array<Hash>]
    def snippets
      Extractor.new(source: source).call
    end

    # @return [String]
    def source
      ::File.read(@file_path)
    end
  end
end
