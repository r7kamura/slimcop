# frozen_string_literal: true

require 'rubocop'

module Slimcop
  # Collect RuboCop offenses from Ruby code.
  class RubyOffenseCollector
    # @param [Boolean] auto_correct
    # @param [String] file_path
    # @param [RuboCop::Config] rubocop_config
    # @param [String] source
    def initialize(auto_correct:, file_path:, rubocop_config:, source:)
      @auto_correct = auto_correct
      @file_path = file_path
      @rubocop_config = rubocop_config
      @source = source
    end

    # @return [Array<RuboCop::Cop::Offense>]
    def call
      # Skip if invalid syntax Ruby code is given. (e.g. "- if a?")
      return [] unless rubocop_processed_source.valid_syntax?

      rubocop_team.investigate(rubocop_processed_source).offenses.reject(&:disabled?)
    end

    private

    # @return [RuboCop::ProcessedSource]
    def rubocop_processed_source
      @rubocop_processed_source ||= ::RuboCop::ProcessedSource.new(
        @source,
        @rubocop_config.target_ruby_version,
        @file_path
      )
    end

    # @return [RuboCop::Cop::Team]
    def rubocop_team
      ::RuboCop::Cop::Team.new(
        ::RuboCop::Cop::Registry.new(::RuboCop::Cop::Cop.all),
        @rubocop_config,
        auto_correct: @auto_correct,
        display_cop_names: true,
        extra_details: true,
        stdin: ''
      )
    end
  end
end
