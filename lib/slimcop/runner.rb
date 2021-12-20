# frozen_string_literal: true

module Slimcop
  # Collect RuboCop offenses from Slim file.
  class Runner
    # @param [String] file_path
    # @param [RuboCop::Config] rubocop_config
    def initialize(file_path:, rubocop_config:)
      @file_path = file_path
      @rubocop_config = rubocop_config
    end

    # @return [Array<Hash>]
    def call
      snippets.flat_map do |snippet|
        OffenseCollector.new(
          file_path: @file_path,
          rubocop_config: @rubocop_config,
          ruby_code: snippet[:code]
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
      CodeExtractor.new(source: source).call
    end

    # @return [String]
    def source
      ::File.read(@file_path)
    end
  end
end
