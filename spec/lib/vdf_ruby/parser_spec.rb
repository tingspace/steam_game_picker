# frozen_string_literal: true

require_relative '../../../lib/vdf_ruby/parser'

RSpec.describe VDFRuby::Parser do
  it 'returns a hash from a provided vdf file' do
    expected_hash = {
      'SaveFile' => {
        'team1' => 'ciccio',
        'team2' => 'pasticcio'
      }
    }
    result = VDFRuby::Parser.new("spec/test_files/ok.vdf").parse
    expect(result.key?('SaveFile')).to eq(true)

    save_file = result['SaveFile']
    expect(save_file['team1']).to eq('ciccio')
    expect(save_file['team2']).to eq('pasticcio')
  end

  it 'provides the complete value string' do
    result = VDFRuby::Parser.new('spec/test_files/appmanifest_9900.acf').parse
    expect(result['AppState']['name']).to eq('Star Trek Online')
  end
end