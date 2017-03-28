require "httparty"

module Cg1
  class FileManipulation
    WORDS_SOURCE = Cg1::config[:words_source]
    TMP_FOLDER = Cg1::config[:tmp_folder]
    @line_number = 0

    class << self
      attr_accessor :line_number

      def clear_temp_images
        FileUtils.rm_rf("#{TMP_FOLDER}/.", secure: true)
      end

      def save_temp_images(images)
        images.each do |img|
          File.open("#{TMP_FOLDER}/tmp_img_#{img[:id]}-#{img[:tag]}.jpg", "wb") do |f| 
            f.write HTTParty.get(img[:url]).parsed_response
            f.close
          end
        end
      end

      def get_tags(processed_tags)
        puts "|getting| 10 more tags from `#{WORDS_SOURCE}`"
        tags = []

        File.foreach(WORDS_SOURCE).with_index do |line, line_num|
          line.strip!
          next if line_num < @line_number || line.size < 3 || line.size > 6 || processed_tags.include?(line)
          tags.push line

          if tags.size > 10
            @line_number = line_num + 1
            break
          end
        end

        puts "|got| 10 tags from `#{WORDS_SOURCE}`:"
        puts tags * ", "

        tags
      end

      def get_temp_images
        Dir.entries("#{TMP_FOLDER}")[2, 10]
      end

    end
  end
end
