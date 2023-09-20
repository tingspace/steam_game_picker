# frozen_string_literal: true

module VDFRuby
  # ESCAPE_CHAR = '\\'
  CURLY_BRACE_OPEN = '{'
  CURLY_BRACE_CLOSE = '}'
  # QUOTATION_MARK = '"'
  COMMENT = '//'

  class Parser
    attr_accessor :contents, :keystore, :parent_key

    def initialize(file_path)
      @contents = IO.read(file_path)
      @keystore = Hash.new
      @parent_key = String.new
    end

    def parse
      contents.each_line(chomp: true) { |line| parse_line(line) }
      @keystore
    end

    private

    def parse_line(line)
      return if line.empty?
      words = line.split(' ')

      return handle_single_token(words) if words.length == 1
      handle_multiple_tokens(words)
    end

    def handle_single_token(words)
      return if words.first == COMMENT
      return if words.first == CURLY_BRACE_OPEN
      return if words.first == CURLY_BRACE_CLOSE

      @parent_key = unquote_token(words.first)
      @keystore[@parent_key] = Hash.new
      nil
    end

    def handle_multiple_tokens(words)
      child_key = String.new
      child_map = @keystore[@parent_key]
      words.each do |w|
        next if unquote_token(w) == COMMENT

        child_key = unquote_token(w) if child_key.empty?
        child_map[child_key] = String.new if child_map.key?(child_key)
        value = String.new

        value = unquote_token(w) unless child_key.empty?
        child_map[child_key] = value unless value.empty?
      end
      nil
    end

    def unquote_token(token)
      token.delete_prefix!('"')
      token.delete_suffix!('"')
      token
    end

  end
end