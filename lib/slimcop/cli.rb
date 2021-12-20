# frozen_string_literal: true

require 'rubocop'

module Slimcop
  class Cli
    def initialize(argv)
      @argv = argv.dup
    end

    def call
      p Runner.new(
        file_path: @argv.first,
        rubocop_config: RuboCop::ConfigLoader.default_configuration
      ).call
    end
  end
end
