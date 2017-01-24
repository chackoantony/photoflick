# Main module to start the program
module PhotoFlick
  
  IMAGE_COUNT = 10
  LAYOUT = { tile: '5x2', width: 228, height: 250 }.freeze
  FLICKR_KEY = 'ef0c85f3cae7a54faa33ae29f0e6addc'.freeze

  autoload :CollageMaker, 'photo_flick/collage_maker'
  autoload :FlickrImageFetcher, 'photo_flick/flickr_image_fetcher'
  autoload :Dictionary, 'photo_flick/dictionary'
  autoload :ImageProcessor, 'photo_flick/image_processor'

  def self.start
    CollageMaker.new.make!
  end

end
