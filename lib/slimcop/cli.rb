# frozen_string_literal: true

require 'optparse'

module Slimcop
  class Cli
    def initialize(argv)
      @argv = argv.dup
    end

    def call
      options = parse!
      @argv.each do |slim_file_path|
        runner = Runner.new(
          file_path: slim_file_path
        )
        if options[:auto_correct]
          ::File.write(
            slim_file_path,
            runner.auto_correct
          )
        else
          lines = runner.offenses.map do |offense|
            format(
              '%<file_path>s:%<line>s:%<column>s %<message>s',
              file_path: offense.file_path,
              line: offense.line,
              column: offense.real_column,
              message: offense.message
            )
          end
          puts lines
        end
      end
    end

    private

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
