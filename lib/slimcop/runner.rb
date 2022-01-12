# frozen_string_literal: true

module Slimcop
  # Run investigation and auto-correcttion.
  class Runner
    # @param [Boolean] auto_correct
    # @param [Array<String>] file_paths
    # @param [Object] formatter
    # @param [RuboCop::Config] rubocop_config
    def initialize(
      auto_correct:,
      file_paths:,
      formatter:,
      rubocop_config:
    )
      @auto_correct = auto_correct
      @file_paths = file_paths
      @formatter = formatter
      @rubocop_config = rubocop_config
    end

    # @return [Array<RuboCop::Cop::Offense>]
    def call
      on_started
      offenses = investigate_and_correct
      on_finished
      offenses
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

    # @return [Array<RuboCop::Cop::Offense>]
    def investigate_and_correct
      @file_paths.flat_map do |file_path|
        offenses_per_file = []
        max_trials_count.times do
          on_file_started(file_path)
          source = ::File.read(file_path)
          offenses = investigate(
            auto_correct: @auto_correct,
            file_path: file_path,
            rubocop_config: @rubocop_config,
            source: source
          )
          offenses_per_file += offenses
          break if offenses.empty?

          if @auto_correct
            correct(
              file_path: file_path,
              offenses: offenses,
              source: source
            )
          end
        end
        on_file_finished(file_path, offenses_per_file)
        offenses_per_file
      end
    end

    # @return [Integer]
    def max_trials_count
      if @auto_correct
        7 # What a heuristic number.
      else
        1
      end
    end

    def on_started
      @formatter.started(@file_paths)
    end

    # @param [String] file_path
    def on_file_started(file_path)
      @formatter.file_started(file_path, {})
    end

    # @param [String] file_path
    # @param [Array<RuboCop::Cop::Offenses]
    def on_file_finished(file_path, offenses)
      @formatter.file_finished(file_path, offenses)
    end

    def on_finished
      @formatter.finished(@file_paths)
    end
  end
end
