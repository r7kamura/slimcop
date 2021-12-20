# frozen_string_literal: true

require_relative 'slimcop/version'

module Slimcop
  autoload :Cli, 'slimcop/cli'
  autoload :CodeExtractor, 'slimcop/code_extractor'
  autoload :Corrector, 'slimcop/corrector'
  autoload :RubyOffenseCollector, 'slimcop/ruby_offense_collector'
  autoload :Runner, 'slimcop/runner'
  autoload :SlimOffenseCollector, 'slimcop/slim_offense_collector'
end
