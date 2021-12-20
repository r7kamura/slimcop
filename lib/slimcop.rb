# frozen_string_literal: true

require_relative 'slimcop/version'

module Slimcop
  autoload :Cli, 'slimcop/cli'
  autoload :RubyExtractor, 'slimcop/ruby_extractor'
  autoload :RubyOffenseCollector, 'slimcop/ruby_offense_collector'
  autoload :Runner, 'slimcop/runner'
  autoload :SlimCorrector, 'slimcop/slim_corrector'
  autoload :SlimOffenseCollector, 'slimcop/slim_offense_collector'
end
