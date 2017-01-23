require 'spec_helper'

describe PhotoFlick::Dictionary do
  
  describe '#get_random_words' do
    it 'returns n random words' do
    	sample = PhotoFlick::Dictionary.new.get_random_words(3)
      expect(sample.length).to eq 3
      expect(sample.first).to be_kind_of(String)
    end
  end

end
