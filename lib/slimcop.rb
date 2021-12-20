# frozen_string_literal: true

require_relative 'slimcop/version'

module Slimcop
  autoload :Cli, 'slimcop/cli'
  autoload :CodeExtractor, 'slimcop/code_extractor'
  autoload :Investigate, 'slimcop/investigate'
  autoload :Runner, 'slimcop/runner'
end
