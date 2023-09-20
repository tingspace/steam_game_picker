# frozen_string_literal: true

module Helpers

  def self.print_nested_hash(hash, nested = false)
    hash.each_pair do |key, value|
      if value.class == Hash
        STDOUT.puts("#{key} =>")
        print_nested_hash(value, true)
        next
      end

      msg = "#{key} => #{value}"
      if nested
        STDOUT.puts("\t#{msg}") if nested
        next
      end

      STDOUT.puts(msg)
    end
  end

end