# frozen_string_literal: true

require 'forwardable'

require 'parser'
require 'rubocop'

module Slimcop
  class Offense
    extend ::Forwardable

    # @return [String]
    attr_reader :file_path

    # @return [Integer]
    attr_reader :offset

    delegate(
      %i[
        column
        column_length
        correctable?
        corrected_with_todo?
        corrected?
        corrector
        highlighted_area
        line
        message
        real_column
        severity
      ] => :rubocop_offense_with_real_location
    )

    # @param [Integer] offset
    # @param [RuboCop::Cop::Offense] rubocop_offense
    # @param [String] source Slim code.
    def initialize(file_path:, offset:, rubocop_offense:, source:)
      @file_path = file_path
      @offset = offset
      @rubocop_offense = rubocop_offense
      @source = source
    end

    # @return [Parser::Source::Range]
    def location
      @location ||= ::Parser::Source::Range.new(
        buffer,
        @rubocop_offense.location.begin_pos + @offset,
        @rubocop_offense.location.end_pos + @offset
      )
    end

    private

    # @return [Parser::Source::Buffer]
    def buffer
      ::Parser::Source::Buffer.new(
        file_path,
        source: @source
      )
    end

    # @return [RuboCop::Cop::Offense]
    def rubocop_offense_with_real_location
      ::RuboCop::Cop::Offense.new(
        @rubocop_offense.severity.name,
        location,
        @rubocop_offense.message,
        @rubocop_offense.cop_name,
        @rubocop_offense.status,
        @rubocop_offense.corrector
      )
    end
  end
end
