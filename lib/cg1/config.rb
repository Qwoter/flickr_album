module Cg1
  # Configuration defaults
  @config = {
              # default output file
              :output_path => "out.jpg",
              # source of random words
              :words_source => '/usr/share/dict/words',
              # flickr keys
              :flickr_api_key => "de5c5e7d36290a0d24dc007fa268d55e",
              :flickr_shared_secret => "2a74156825c64301",
              # location of temporal image store folder
              :tmp_folder => './tmp'
            }

  def self.config
    @config
  end
end
