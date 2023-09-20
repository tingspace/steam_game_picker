# frozen_string_literal: true

# NOTE: This is a simple script to test the VDFRuby parser.
# I am aware that testing in this way is like banging rocks together

require 'json'
require_relative './lib/vdf_ruby/parser'

library_vdf = VDFRuby::Parser.new("spec/test_files/libraryfolders.vdf").parse
STDOUT.puts(JSON.generate(library_vdf))