# frozen_string_literal: true

require 'optparse'
require 'rubocop'

module Slimcop
  class Cli
    def initialize(argv)
      @argv = argv.dup
    end

    def call
      options = parse!
      runner = Runner.new(
        file_path: @argv.first,
        rubocop_config: RuboCop::ConfigLoader.default_configuration
      )
      p runner.offenses
      runner.auto_correct if options[:auto_correct]
    end

    private

    # @return [Hash]
    def parse!
      options = {}
      parser = ::OptionParser.new
      parser.on('-a', '--auto-correct', 'Auto-correct offenses.') do
        options[:auto_correct] = true
      end
      parser.parse!(@argv)
      options
    end
  end
end
