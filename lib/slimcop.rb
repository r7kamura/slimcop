# frozen_string_literal: true

require_relative 'slimcop/version'

module Slimcop
  autoload :Cli, 'slimcop/cli'
  autoload :Offense, 'slimcop/offense'
  autoload :PathFinder, 'slimcop/path_finder'
  autoload :RuboCopConfigGenerator, 'slimcop/rubo_cop_config_generator'
  autoload :RubyClipper, 'slimcop/ruby_clipper'
  autoload :RubyExtractor, 'slimcop/ruby_extractor'
  autoload :RubyOffenseCollector, 'slimcop/ruby_offense_collector'
  autoload :SlimCorrector, 'slimcop/slim_corrector'
  autoload :SlimOffenseCollector, 'slimcop/slim_offense_collector'
end
