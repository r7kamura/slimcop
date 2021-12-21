# frozen_string_literal: true

require 'rubocop'

module Slimcop
  # Report offenses in Slim file, and apply auto-corrections if required.
  class Runner
    # @param [String] file_path
    def initialize(file_path:)
      @file_path = file_path
    end

    # @return [Array<Slimcop::Offense>]
    def offenses
      @offenses ||= SlimOffenseCollector.new(
        file_path: @file_path,
        rubocop_config: rubocop_config,
        source: source
      ).call
    end

    def auto_correct
      SlimCorrector.new(
        file_path: @file_path,
        offenses: offenses,
        source: source
      ).call
    end

    private

    # @return [RuboCop::Config]
    def rubocop_config
      config_path = ::File.expand_path('../../default.yml', __dir__)
      config = ::RuboCop::ConfigLoader.load_file(config_path)
      ::RuboCop::ConfigLoader.merge_with_default(config, config_path)
    end

    # @return [String]
    def source
      ::File.read(@file_path)
    end
  end
end
