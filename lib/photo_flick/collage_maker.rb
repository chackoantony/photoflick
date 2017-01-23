module PhotoFlick

	class CollageMaker
		require 'fileutils'

		def make
			get_inputs
			process
		rescue => e
		  puts e.message
		end
		
		private
		
		def process
			puts 'Please wait while processing images...'	 
			fetch_images
			create_collage
      FileUtils.rm_rf('tmp')
		end

	  def fetch_images
	  	PhotoFlick::FlickrImageFetcher.new(@keywords).fetch_images()
	  rescue => e
	  	raise "Error while fetching images: #{e.message}"
	  end

	  def create_collage 
      PhotoFlick::ImageProcessor.new.create_collage(@output_file)
    rescue => e
	    raise "Error while processing images: #{e.message}"
	  end


	  def get_inputs
	    @keywords = []
      puts 'Enter your search keywords on each line:'
      10.times { @keywords << gets.chomp }
      @keywords.reject!(&:empty?)
      puts 'Enter output file name with extension (JPG|PNG|GIF)'
      @output_file = gets.chomp
      @output_file = 'output.jpg' if @output_file.empty?
      validate_output_file(@output_file)
    end

	  def validate_output_file(file)
	  	return if %w(.jpg .png .gif).include? File.extname(file)
      raise "Error: This file extension not supported!"
	  end

	end
		
end