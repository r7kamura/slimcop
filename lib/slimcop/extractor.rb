# frozen_string_literal: true

require 'slimi'

module Slimcop
  # Convert Slimi AST into embedded Ruby code info.
  class Extractor
    # @param [String] source
    def initialize(source:)
      @source = source
    end

    # @return [Array<Hash>]
    def call
      ranges.map do |(begin_, end_)|
        {
          begin_: begin_,
          code: @source[begin_...end_],
          end_: end_
        }
      end
    end

    private

    # @return [Array] Slim AST, represented in S-expression.
    def ast
      ::Slimi::Filters::Interpolation.new.call(
        ::Slimi::Parser.new.call(@source)
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
