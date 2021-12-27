# frozen_string_literal: true

require 'rainbow'

module Slimcop
  class Cli
    def initialize(argv)
      @argv = argv.dup
      @formatter = Formatter.new
    end

    def call
      options = parse!
      Rainbow.enabled = options[:color] if options.key?(:color)
      rubocop_config = RuboCopConfigGenerator.new(additional_config_file_path: options[:additional_config_file_path]).call
      file_paths = PathFinder.new(patterns: @argv).call

      offenses = file_paths.flat_map do |file_path|
        source = ::File.read(file_path)
        offenses_ = investigate(
          auto_correct: options[:auto_correct],
          file_path: file_path,
          rubocop_config: rubocop_config,
          source: source
        )
        if options[:auto_correct]
          correct(
            file_path: file_path,
            offenses: offenses_,
            source: source
          )
        end
        offenses_
      end
      report(offenses)
      exit(offenses.empty? ? 0 : 1)
    end

    private

    # @param [String] file_path
    # @param [Array<Slimcop::Offense>] offenses
    # @param [String] source
    def correct(file_path:, offenses:, source:)
      rewritten_source = SlimCorrector.new(
        file_path: file_path,
        offenses: offenses,
        source: source
      ).call
      ::File.write(file_path, rewritten_source)
    end

    # @param [Boolean] auto_correct
    # @param [String] file_path
    # @param [String] rubocop_config
    # @param [String] source
    # @return [Array<Slimcop::Offense>]
    def investigate(auto_correct:, file_path:, rubocop_config:, source:)
      SlimOffenseCollector.new(
        auto_correct: auto_correct,
        file_path: file_path,
        rubocop_config: rubocop_config,
        source: source
      ).call
    end

    # @param [Array<Slimcop::Offense>] offenses
    def report(offenses)
      result = +''
      unless offenses.empty?
        result << "\nOffenses:\n\n"
        lines = offenses.map do |offense|
          @formatter.format_offense(offense)
        end
        result << lines.join("\n")
      end
      puts(result)
    end

    # @return [Hash]
    def parse!
      options = {}
      parser = ::OptionParser.new
      parser.banner = 'Usage: slimcop [options] [file1, file2, ...]'
      parser.on('-a', '--auto-correct', 'Auto-correct offenses.') do
        options[:auto_correct] = true
      end
      parser.on('-c', '--config=', 'Specify configuration file.') do |file_path|
        options[:additional_config_file_path] = file_path
      end
      parser.on('--[no-]color', 'Force color output on or off.') do |value|
        options[:color] = value
      end
      parser.parse!(@argv)
      options
    end
  end
end
