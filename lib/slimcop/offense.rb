# frozen_string_literal: true

require 'parser'

module Slimcop
  class Offense
    # @return [Integer]
    attr_reader :offset

    # @param [Integer] offset
    # @param [RuboCop::Cop::Offense] rubocop_offense
    # @param [String] source Slim code.
    def initialize(offset:, rubocop_offense:, source:)
      @offset = offset
      @rubocop_offense = rubocop_offense
      @source = source
    end

    # @return [Boolean]
    def correctable?
      @rubocop_offense.correctable?
    end

    # @return [RuboCop::Cop::Corrector]
    def corrector
      @rubocop_offense.corrector
    end

    # @return [String]
    def file_path
      @rubocop_offense.location.source_buffer.name
    end

    # @return [Integer]
    def line
      range.line
    end

    # @return [String]
    def message
      @rubocop_offense.message
    end

    # @return [Integer]
    def real_column
      range.column + 1
    end

    # @return [RuboCop::Cop::Severity]
    def severity
      @rubocop_offense.severity
    end

    private

    # @return [Parser::Source::Buffer]
    def buffer
      ::Parser::Source::Buffer.new(
        file_path,
        source: @source
      )
    end

    # @return [Parser::Source::Range]
    def range
      @range ||= ::Parser::Source::Range.new(
        buffer,
        @rubocop_offense.location.begin_pos + @offset,
        @rubocop_offense.location.end_pos + @offset
      )
    end
  end
end
