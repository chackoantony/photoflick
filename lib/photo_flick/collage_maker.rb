module PhotoFlick
  # This class responsible to create collage from flickr images
  class CollageMaker
    require 'fileutils'

    # Main triggering method
    def make!
      get_inputs
      puts 'Please wait while processing images...'
      find_images
      create_collage
      puts "Succesfully generated collage image #{Dir.pwd}/#{@output_file}"
      # clean up temp folder
      FileUtils.rm_rf('tmp')
    end
    
    private
    
    # Read inputs from user
    def get_inputs
      @keywords = []
      puts 'Enter your search keywords line by line:'
      10.times { @keywords << gets.chomp }
      @keywords.reject!(&:empty?)
      puts 'Enter output file name with extension (JPG|PNG|GIF)'
      loop do
        @output_file = gets.chomp
        @output_file = 'output.jpg' if @output_file.empty?
        break if valid_output_file?(@output_file)
        puts 'Sorry! This file format not supported.'
      end
    end

    def find_images
      PhotoFlick::FlickrImageFetcher.new(@keywords).fetch_images!
    rescue => e
      raise "Error while fetching images: #{e.message}"
    end

    def create_collage
      PhotoFlick::ImageProcessor.new(@output_file).create_collage!
    rescue => e
      raise "Error while processing images: #{e.message}"
    end

    def valid_output_file?(file)
      %w(.jpg .png .gif).include? File.extname(file)
    end

  end
end
