module PhotoFlick
  # This class responsible for interacting with Flickr API
  class FlickrImageFetcher
    require 'flickraw'
    require 'open-uri'

    FlickRaw.api_key = PhotoFlick::FLICKR_KEY
    FlickRaw.shared_secret= ''

    def initialize(keywords)
      @keywords = keywords
    end

    # Get all images from Flickr
    def fetch_images!
      validate_keywords
      @keywords.each do |keyword|
        image = nil
        loop do
          image = flickr.photos.search(text: keyword, 
                                       sort: 'interestingness-desc', 
                                       privacy_filter: 1, 
                                       per_page: 1).first
          break if image
          # Repeat with a random word if image not found 
          keyword = dictionary.get_random_words(1).first
        end   
        download_image(image)
      end  
    end

    private 

    # Validate count of keywords
    def validate_keywords
      return if (keyword_count = @keywords.length) == PhotoFlick::IMAGE_COUNT
      @keywords.concat dictionary.get_random_words(PhotoFlick::IMAGE_COUNT - keyword_count) 
    end

    # Downloads found images to 'tmp' folder
    def download_image(image)
      url = FlickRaw.url(image)
      Dir.mkdir('tmp') unless File.exists? 'tmp'
      open(url) do |f|
        File.open("tmp/#{image['id']}.jpg","wb") do |file|
          file.puts f.read
        end
      end
    end 

    def dictionary
      @dictionary ||= PhotoFlick::Dictionary.new
    end

  end

end