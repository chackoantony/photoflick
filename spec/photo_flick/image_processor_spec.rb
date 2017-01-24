require 'spec_helper'
require 'fileutils'

describe PhotoFlick::ImageProcessor do

  before(:all) do
    root_path = File.expand_path('../../../' , __FILE__)
    FileUtils.mkdir_p(root_path + '/tmp')
    FileUtils.cp("#{root_path}/spec/data/test.jpg", "#{root_path}/tmp")
  end

  describe '#create_collage!' do
    it 'generates a collage image' do
      image_processor = PhotoFlick::ImageProcessor.new('output.png') 
      image_processor.create_collage!
      expect(File.exist?('output.png')).to be_truthy
    end
  end

end
