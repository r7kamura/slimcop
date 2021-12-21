# frozen_string_literal: true

require 'optparse'
require 'rainbow'

module Slimcop
  class Cli
    COLOR_FOR_SEVERITY_CODE = {
      convention: :yellow,
      error: :red,
      fatal: :red,
      info: :gray,
      refactor: :yellow,
      warning: :magenta
    }.freeze

    def initialize(argv)
      @argv = argv.dup
      @configuration = Configuration.new
    end

    def call
      options = parse!
      slim_file_paths = @argv

      offenses_set = investigate(slim_file_paths)
      correct(offenses_set) if options[:auto_correct]
      offenses = offenses_set.flat_map { |(_, _, array)| array }
      report(offenses)
      exit(offenses.empty? ? 0 : 1)
    end

    private

    # @param [Array] offenses_set
    def correct(offenses_set)
      offenses_set.each do |(file_path, source, offenses)|
        rewritten_source = SlimCorrector.new(
          file_path: file_path,
          offenses: offenses,
          source: source
        ).call
        ::File.write(file_path, rewritten_source)
      end
    end

    # @param [Array] slim_file_paths
    # @return [Array]
    def investigate(slim_file_paths)
      slim_file_paths.map do |file_path|
        source = ::File.read(file_path)
        offenses = SlimOffenseCollector.new(
          file_path: file_path,
          rubocop_config: @configuration.rubocop_config,
          source: source
        ).call
        [file_path, source, offenses]
      end
    end

    # @param [Array<Slimcop::Offense>] offenses
    def report(offenses)
      lines = offenses.map do |offense|
        format(
          '%<file_path>s:%<line>i:%<column>i %<severity_code>s: %<correctability>s%<message>s',
          column: offense.real_column,
          correctability: offense.correctable? ? Rainbow('[Correctable] ').yellow : '',
          file_path: Rainbow(offense.file_path).cyan,
          line: offense.line,
          message: offense.message,
          severity_code: Rainbow(offense.severity.code).color(COLOR_FOR_SEVERITY_CODE[offense.severity.name])
        )
      end
      puts(lines)
    end

    # @return [Hash]
    def parse!
      options = {}
      parser = ::OptionParser.new
      parser.banner = 'Usage: slimcop [options] [file1, file2, ...]'
      parser.on('-a', '--auto-correct', 'Auto-correct offenses.') do
        options[:auto_correct] = true
      end
      parser.parse!(@argv)
      options
    end
  end
end
