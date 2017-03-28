require 'thor'
require 'cg1/commander'

module Cg1
  class CliInterface < Thor
    desc "tags TAG1,TAG2,TAG3...", "will give college album from Flickr using tags source: `#{Cg1::config[:output_path]}`"
    desc "tags TAG1,TAG2,TAG3... [-o] FILE_PATH", "will set output file name and path"

    long_desc <<-DESCRIPTION
    `cg tags TAG1,TAG2...` will give college album from Flickr using tags source: `#{Cg1::config[:output_path]}`
    `cg tags TAG1,TAG2,TAG3... -o FILE_PATH`, will give college album from Flickr using tags source: `FILE_PATH`
    DESCRIPTION

    option :o
    def tags(user_tags)
      if options[:o]
        Commander.output_path = options[:o]
      end

      Commander.tags = user_tags.split(",")
      Commander.start
    end
  end
end
