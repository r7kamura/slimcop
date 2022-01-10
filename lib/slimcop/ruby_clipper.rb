# frozen_string_literal: true

module Slimcop
  # Remove unnecessary part (e.g. `if`, `unless`, `do`, ...) from Ruby code.
  class RubyClipper
    # @param [String] code
    def initialize(code)
      @code = code
    end

    # @return [Hash]
    def call
      [
        PrecedingKeywordRemover,
        TrailingDoRemover
      ].each_with_object(
        code: @code,
        offset: 0
      ) do |klass, object|
        result = klass.new(object[:code]).call
        object[:code] = result[:code]
        object[:offset] += result[:offset]
      end
    end

    class PrecedingKeywordRemover
      REGEXP = /
        \A
        (?:
          begin
          | case
          | else
          | elsif
          | ensure
          | if
          | rescue
          | unless
          | until
          | when
          | while
          | for[ \t]+\w+[ \t]+in
        )
        [ \t]
      /x.freeze

      # @param [String] code
      def initialize(code)
        @code = code
      end

      # @return [Hash]
      def call
        data = @code.match(REGEXP)
        if data
          offset = data[0].length
          {
            code: @code[offset..],
            offset: offset
          }
        else
          {
            code: @code,
            offset: 0
          }
        end
      end
    end

    class TrailingDoRemover
      REGEXP = /
        [ \t]
        do
        [ \t]*
        (\|[^|]*\|)?
        [ \t]*
        \Z
      /x.freeze

      # @param [String] code
      def initialize(code)
        @code = code
      end

      # @return [Hash]
      def call
        {
          code: @code.sub(REGEXP, ''),
          offset: 0
        }
      end
    end
  end
end
