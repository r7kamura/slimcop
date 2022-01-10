# frozen_string_literal: true

require 'slimi'

module Slimcop
  # Extract codes from Slim source.
  class RubyExtractor
    # @param [String, nil] file_path
    # @param [String] source
    def initialize(file_path:, source:)
      @file_path = file_path
      @source = source
    end

    # @return [Array<Hash>]
    def call
      ranges.map do |(begin_, end_)|
        {
          code: @source[begin_...end_],
          offset: begin_
        }
      end
    end

    private

    # @return [Array] Slim AST, represented in S-expression.
    def ast
      ::Slimi::Filters::Interpolation.new.call(
        ::Slimi::Parser.new(file: @file_path).call(@source)
      )
    end

    # @return [Array<Array<Integer>>]
    def ranges
      result = []
      traverse(ast) do |begin_, end_|
        result << [begin_, end_]
      end
      result
    end

    def traverse(node, &block)
      return unless node.instance_of?(::Array)

      if node[0] == :slimi && node[1] == :position
        block.call(node[2], node[3])
      else
        node.each do |element|
          traverse(element, &block)
        end
      end
    end
  end
end
