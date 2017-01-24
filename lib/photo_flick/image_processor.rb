module PhotoFlick
  # This class responsible for creating collage using ImageMagick.
  class ImageProcessor
    require 'mini_magick'

    def initialize(output_file)
      @output_file = output_file
    end

    def create_collage!
      Dir[Dir.pwd + "/tmp/*.jpg"].each do |f|
        image = resize_images(f)
        image.format 'jpg'
        image.write "tmp/#{File.basename(f)}"
      end
      build_montage
    end

    private

    # Resize images to fit into collage tiles
    def resize_images(image_file)
      width = PhotoFlick::LAYOUT[:width]
      height = PhotoFlick::LAYOUT[:height]
      image = MiniMagick::Image.open(image_file)
      cols, rows = image[:dimensions]
      image.combine_options do |cmd|
        if width != cols || height != rows
          scale_x = width / cols.to_f
          scale_y = height / rows.to_f
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
        cmd.background 'rgba(255,255,255,0.0)'
        cmd.extent "#{width}x#{height}" if cols != width || rows != height
      end
    end

    # Create collage using Imagemagick 'montage' command
    def build_montage
      montage = MiniMagick::Tool::Montage.new
      Dir[Dir.pwd + '/tmp/*.jpg'].each { |image| montage << image }
      montage << '-mode'
      montage << 'Concatenate'
      montage << '-background'
      montage << 'white'
      montage << '-geometry'
      montage << "#{PhotoFlick::LAYOUT[:width]}x#{PhotoFlick::LAYOUT[:height]}+1+1"
      montage << '-tile'
      montage << PhotoFlick::LAYOUT[:tile]
      montage << @output_file
      montage.call
    end

  end
end
