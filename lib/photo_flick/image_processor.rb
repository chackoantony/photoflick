module PhotoFlick

	class ImageProcessor
    require 'mini_magick'

		def initialize
      @files = Dir[Dir.pwd + "/tmp/*.jpg"]
      @width = PhotoFlick::LAYOUT[:width]
      @height = PhotoFlick::LAYOUT[:height]
		end

		def create_collage output_file
      @files.each do |f|
        image = resize_images(f)
        image.format "jpg"
        image.write "tmp/#{f.split('/').last}"
      end
      build_montage(output_file)
		end

		private

		def resize_images(image_file)
			image = MiniMagick::Image.open(image_file)
	    cols, rows = image[:dimensions]
	    image.combine_options do |cmd|
		    if @width != cols || @height != rows
		      scale_x = @width/cols.to_f
		      scale_y = @height/rows.to_f
		      if scale_x >= scale_y
		        cols = (scale_x * (cols + 0.5)).round
		        rows = (scale_x * (rows + 0.5)).round
		        cmd.resize "#{cols}"
		      else
		        cols = (scale_y * (cols + 0.5)).round
		        rows = (scale_y * (rows + 0.5)).round
		        cmd.resize "x#{rows}"
		      end
		    end
		    cmd.gravity 'Center'
		    cmd.background "rgba(255,255,255,0.0)"
		    cmd.extent "#{@width}x#{@height}" if cols != @width || rows != @height
		  end  
	  end

	  def build_montage output_file
			montage = MiniMagick::Tool::Montage.new
			Dir[Dir.pwd + "/tmp/*.jpg"].each { |image| montage << image }
			montage << '-mode'
			montage << 'Concatenate'
			montage << '-background'
			montage << 'none'
			montage << '-geometry'
			montage << "#{@width}x#{@height}+1+1"
			montage << '-tile'
			montage << PhotoFlick::LAYOUT[:tile]
			montage << output_file
			montage.call
	  end

	end

end		