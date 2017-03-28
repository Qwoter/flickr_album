require 'rmagick'

module Cg1
  class ImageManipulation
  include Magick

    def self.combine(output_path)
      tmp_images = FileManipulation.get_temp_images
      row = 2
      col = 5
      ilg = ImageList.new

      1.upto(row) {|x| il = ImageList.new
      1.upto(col) {|y| il.push(Image.read("#{FileManipulation::TMP_FOLDER}/" + tmp_images.shift).first)}

      ilg.push(il.append(false))}
      ilg.append(true).write(output_path)
    end

    def self.add_text
      tmp_images = FileManipulation.get_temp_images

      while tmp_images.size > 0
        image_name = tmp_images.shift
        image_tag = image_name.split('-').last[0..-5]
        img = ImageList.new("#{FileManipulation::TMP_FOLDER}/#{image_name}")
        txt = Draw.new

        img.annotate(txt, 0,0,0,0, image_tag) {
          txt.gravity = Magick::SouthGravity
          txt.pointsize = 25
          txt.stroke = '#d46214'
          txt.fill = '#ffffff'
          txt.font_weight = Magick::BoldWeight
        }

        img.format = 'jpg'
        img.write("#{FileManipulation::TMP_FOLDER}/#{image_name}")
      end
    end
  end
end
