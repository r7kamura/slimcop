# frozen_string_literal: true

require 'optparse'

module Slimcop
  # Format String for CLI output.
  class Formatter
    COLOR_FOR_SEVERITY_CODE = {
      convention: :yellow,
      error: :red,
      fatal: :red,
      info: :gray,
      refactor: :yellow,
      warning: :magenta
    }.freeze

    # @param [Slimcop::Offense] offense
    # @return [String]
    def format_offense(offense)
      format(
        '%<file_path>s:%<line>i:%<column>i %<severity_code>s: %<correctability>s%<message>s',
        column: offense.real_column,
        correctability: correctability(offense),
        file_path: Rainbow(offense.file_path).cyan,
        line: offense.line,
        message: offense.message,
        severity_code: severity_code(offense)
      )
    end

    private

    # @param [Slimcop::Offense] offense
    # @return [String]
    def correctability(offense)
      if offense.correctable?
        "#{Rainbow('[Correctable]').yellow} "
      else
        ''
      end
    end

    # @param [Slimcop::Offense] offense
    # @return [String]
    def severity_code(offense)
      Rainbow(offense.severity.code).color(COLOR_FOR_SEVERITY_CODE[offense.severity.name])
    end
  end
end
