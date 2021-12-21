# frozen_string_literal: true

module Slimcop
  # Collect RuboCop offenses from Slim code.
  class SlimOffenseCollector
    # @param [Boolean] auto_correct
    # @param [String] file_path Slim file path
    # @param [RuboCop::Config] rubocop_config
    # @param [String] source Slim code
    def initialize(auto_correct:, file_path:, rubocop_config:, source:)
      @auto_correct = auto_correct
      @file_path = file_path
      @rubocop_config = rubocop_config
      @source = source
    end

    # @return [Array<Slimcop::Offense>]
    def call
      snippets.flat_map do |snippet|
        RubyOffenseCollector.new(
          auto_correct: @auto_correct,
          file_path: @file_path,
          rubocop_config: @rubocop_config,
          source: snippet[:code]
        ).call.map do |rubocop_offense|
          Offense.new(
            offset: snippet[:begin_],
            rubocop_offense: rubocop_offense,
            source: @source
          )
        end
      end
    end

    private

    # @return [Array<Hash>]
    def snippets
      RubyExtractor.new(source: @source).call
    end
  end
end
