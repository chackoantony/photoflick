require 'spec_helper'

RSpec.describe PhotoFlick do
  
  it 'has a version number' do
    expect(PhotoFlick::VERSION).not_to be nil
  end

  it 'responds to start method' do
    expect(PhotoFlick).to respond_to(:start)
  end
  
end
