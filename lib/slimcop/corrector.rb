# frozen_string_literal: true

require 'rubocop/cop/legacy/corrector'

module Slimcop
  # Apply given offenses' auto-corrections to specified file.
  class Corrector
    # @param [String] file_path
    # @param [Array<Hash>] offenses
    def initialize(file_path:, offenses:)
      @file_path = file_path
      @offenses = offenses
    end

    def call
      ::RuboCop::Cop::Legacy::Corrector.new(source_buffer, corrections).rewrite
    end

    private

    # @return [Array<Proc>]
    def corrections
      @offenses.map do |offense|
        lambda do |corrector|
          corrector.import!(offense[:rubocop_offense].corrector, offset: offense[:offset])
        end
      end
    end

    # @return [Parser::Source::Buffer]
    def source_buffer
      ::Parser::Source::Buffer.new(
        @file_path,
        source: ::File.read(@file_path)
      )
    end
  end
end
