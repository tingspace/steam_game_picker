# frozen_string_literal: true

require 'json'
require_relative './lib/vdf_ruby/parser'
require_relative './lib/helpers/print_helpers'

# ok_vdf = VDFRuby::Parser.new("spec/test_files/ok.vdf").parse
library_vdf = VDFRuby::Parser.new("spec/test_files/libraryfolders.vdf").parse
# Helpers.print_nested_hash(library_vdf)

STDOUT.puts(JSON.generate(library_vdf))