# frozen_string_literal: true

require_relative 'slimcop/version'

module Slimcop
  autoload :Cli, 'slimcop/cli'
  autoload :Configuration, 'slimcop/configuration'
  autoload :FileCollector, 'slimcop/file_collector'
  autoload :Formatter, 'slimcop/formatter'
  autoload :Offense, 'slimcop/offense'
  autoload :RubyExtractor, 'slimcop/ruby_extractor'
  autoload :RubyOffenseCollector, 'slimcop/ruby_offense_collector'
  autoload :SlimCorrector, 'slimcop/slim_corrector'
  autoload :SlimOffenseCollector, 'slimcop/slim_offense_collector'
end
