# frozen_string_literal: true

module VDFRuby
  # ESCAPE_CHAR = '\\'
  CURLY_BRACE_OPEN = '{'
  CURLY_BRACE_CLOSE = '}'
  # QUOTATION_MARK = '"'
  COMMENT = '//'
  SKIP_TOKENS = [CURLY_BRACE_OPEN, CURLY_BRACE_CLOSE, COMMENT]

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
      words = line.split(' ').map { |w| unquote(w) }

      return handle_single_token(words) if words.length == 1
      handle_multiple_tokens(words)
    end

    def handle_single_token(words)
      return if SKIP_TOKENS.include?(words.first)
      @parent_key = words.first
      @keystore[@parent_key] = Hash.new
      nil
    end

    def handle_multiple_tokens(words)
      child_map = @keystore[@parent_key]
      child_key = words.first
      child_map[child_key] = words[1..-1].select { |w| true unless SKIP_TOKENS.include?(w) }.join(' ')
      nil
    end

    def unquote(token)
      token.delete_prefix!('"')
      token.delete_suffix!('"')
      token
    end

  end
end