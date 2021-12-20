# frozen_string_literal: true

require_relative 'slimcop/version'

module Slimcop
  autoload :Cli, 'slimcop/cli'
  autoload :CodeExtractor, 'slimcop/code_extractor'
  autoload :OffenseCollector, 'slimcop/offense_collector'
  autoload :Runner, 'slimcop/runner'
end
