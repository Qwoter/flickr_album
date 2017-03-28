require 'flickraw-cached'

module Cg1
  class FlickrClient
    def initialize(*opt)
      FlickRaw.api_key = Cg1::config[:flickr_api_key]
      FlickRaw.shared_secret = Cg1::config[:flickr_shared_secret]
    end

    def search_by_tags(user_tags)
      found_images_count = 0
      search_tags = user_tags
      processed_tags = []
      images = []

      while found_images_count < 10
        if search_tags.size == 0
          search_tags = FileManipulation.get_tags(processed_tags)
        end

        args = {tags: "", per_page: 1, sort: "interestingness-desc", tag_mode: "all"}
        args[:tags] = prepare_tags(search_tags, processed_tags)
        discovered_pictures = flickr.photos.search(args)

        if discovered_pictures.size != 1
          search_tags.pop
        else
          found_images_count += 1
          tag = search_tags.pop
          processed_tags.push(tag)

          # url = FlickRaw.url discovered_pictures[0]
          id = discovered_pictures[0]["id"]
          sizes = flickr.photos.getSizes(:photo_id => id)
          url = sizes.select{|s| s["label"] == "Large Square"}.first["source"]

          images.push({id: id, url: url, tag: tag})
          puts "|found| tag:#{tag} url:#{url} id:#{id}"
        end
      end

      images
    end

    private
    def prepare_tags(search_tags, processed_tags)
      "#{search_tags[-1]}" + processed_tags.reduce('') {|s, t| s += ",-" + t; s}
    end
  end
end
