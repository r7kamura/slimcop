# frozen_string_literal: true

module Slimcop
  # Collect RuboCop offenses from Slim code.
  class SlimOffenseCollector
    # @param [String] file_path Slim file path
    # @param [RuboCop::Config] rubocop_config
    # @param [String] source Slim code
    def initialize(file_path:, rubocop_config:, source:)
      @file_path = file_path
      @rubocop_config = rubocop_config
      @source = source
    end

    # @return [Array<Hash>]
    def call
      snippets.flat_map do |snippet|
        RubyOffenseCollector.new(
          file_path: @file_path,
          rubocop_config: @rubocop_config,
          source: snippet[:code]
        ).call.map do |rubocop_offense|
          {
            offset: snippet[:begin_],
            rubocop_offense: rubocop_offense
          }
        end
      end
    end

    private

    # @return [Array<Hash>]
    def snippets
      CodeExtractor.new(source: @source).call
    end
  end
end
