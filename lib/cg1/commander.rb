require 'cg1/api_client'
require 'cg1/file_manipulation'
require 'cg1/image_manipulation'

module Cg1
  class Commander
    @tags = []
    @output_path = Cg1::config[:output_path]

    class << self
      attr_accessor :tags, :output_path

      def start
        puts "|searching| for images using tags:#{@tags*", "}"
        images = client.search_by_tags(@tags)

        puts "|saving| images to temp folder"
        FileManipulation.save_temp_images(images)

        puts "|add_tags| adding tags to pictures"
        ImageManipulation.add_text

        puts "|combining| images to `#{@output_path}`"
        ImageManipulation.combine(@output_path)

        FileManipulation.clear_temp_images
      end

      private
      def client
        FlickrClient.new
      end

    end
  end
end
