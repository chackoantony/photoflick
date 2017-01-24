require 'spec_helper'
require 'fileutils'

describe PhotoFlick::CollageMaker do

  before(:all) do
    root_path = File.expand_path('../../../' , __FILE__)
    FileUtils.mkdir_p(root_path + '/tmp')
    FileUtils.cp("#{root_path}/spec/data/test.jpg", "#{root_path}/tmp")
  end

  describe '#make!' do
    it 'create a collage image from search keywords' do
      keywords = %w(india germany)
      collage_maker = PhotoFlick::CollageMaker.new
      collage_maker.stub(:get_inputs)
      collage_maker.instance_variable_set(:@keywords, keywords)
      collage_maker.instance_variable_set(:@output_file, 'output.jpg')
      PhotoFlick::FlickrImageFetcher.any_instance.stub(:fetch_images!)
      collage_maker.make!
      expect(File.exist?('output.jpg')).to be_truthy
    end
  end

end
