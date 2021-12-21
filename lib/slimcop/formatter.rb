# frozen_string_literal: true

require 'optparse'
require 'rainbow'

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
        '%<path>s:%<line>d:%<column>d %<severity>s: %<message>s',
        column: offense.real_column,
        line: offense.line,
        message: message(offense),
        path: file_path(offense),
        severity: severity(offense)
      )
    end

    private

    # @param [String] path e.g. "./spec/fixtures/dummy.slim"
    # @return [String]
    # @example "spec/fixtures/dummy.slim"
    def canonicalize_path(path)
      ::File.expand_path(path).delete_prefix("#{::Dir.pwd}/")
    end

    # @param [Slimcop::Offense] offense
    # @return [String]
    def file_path(offense)
      Rainbow(canonicalize_path(offense.file_path)).cyan
    end

    # @param [Slimcop::Offense] offense
    # @return [String]
    def message(offense)
      "#{status(offense)}#{offense.message}"
    end

    # @param [Slimcop::Offense] offense
    # @return [String]
    def severity(offense)
      Rainbow(offense.severity.code).color(COLOR_FOR_SEVERITY_CODE[offense.severity.name])
    end

    # @param [Slimcop::Offense] offense
    # @return [String]
    def status(offense)
      if offense.rubocop_offense.corrected_with_todo?
        Rainbow('[Todo] ').green
      elsif offense.rubocop_offense.corrected?
        Rainbow('[Corrected] ').green
      elsif offense.rubocop_offense.correctable?
        Rainbow('[Correctable] ').yellow
      else
        ''
      end
    end
  end
end
