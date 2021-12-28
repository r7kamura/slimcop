# frozen_string_literal: true

require 'pathname'

module Slimcop
  # Collect file paths from given path patterns.
  class PathFinder
    # @param [Array<String>] patterns Patterns normally given as CLI arguments (e.g. `["app/views/**/*.html.slim"]`).
    def initialize(patterns:)
      @patterns = patterns
    end

    # @return [Array<String>]
    def call
      @patterns.flat_map do |pattern|
        ::Pathname.glob(pattern).select(&:file?).map(&:to_s)
      end.uniq.sort
    end
  end
end
