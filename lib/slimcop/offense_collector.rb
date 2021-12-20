# frozen_string_literal: true

require 'rubocop'

module Slimcop
  # Collect RuboCop offenses from Ruby code.
  class OffenseCollector
    # @param [String] ruby_code
    # @param [String] file_path
    # @param [RuboCop::Config] rubocop_config
    def initialize(file_path:, rubocop_config:, ruby_code:)
      @file_path = file_path
      @rubocop_config = rubocop_config
      @ruby_code = ruby_code
    end

    # @return [RuboCop::Cop::Commissioner::InvestigationReport, nil]
    def call
      return unless rubocop_processed_source.valid_syntax?

      rubocop_team.investigate(rubocop_processed_source)
    end

    private

    # @return [RuboCop::ProcessedSource]
    def rubocop_processed_source
      @rubocop_processed_source ||= ::RuboCop::ProcessedSource.new(
        @ruby_code,
        @rubocop_config.target_ruby_version,
        @file_path
      )
    end

    # @return [RuboCop::Cop::Team]
    def rubocop_team
      ::RuboCop::Cop::Team.new(
        ::RuboCop::Cop::Registry.new(::RuboCop::Cop::Cop.all),
        @rubocop_config,
        auto_correct: true,
        display_cop_names: true,
        extra_details: true,
        stdin: ''
      )
    end
  end
end
