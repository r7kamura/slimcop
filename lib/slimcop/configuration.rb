# frozen_string_literal: true

require 'rubocop'

module Slimcop
  class Configuration
    # @return [RuboCop::Config]
    def rubocop_config
      @rubocop_config ||= begin
        config_path = ::File.expand_path('../../default.yml', __dir__)
        config = ::RuboCop::ConfigLoader.load_file(config_path)
        ::RuboCop::ConfigLoader.merge_with_default(config, config_path)
      end
    end
  end
end
