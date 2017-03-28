# College Grid gem

Gem for downloading and combining images from Flickr using tags.

## Installation

Download source code

    $ git clone git@github.com:Qwoter/flickr_album.git

Check `cg1/lib/cg1/config.rb` and set config variables

Create temp folder (Default `./tmp`)

Install dependencies

    $ bundle

Install gem (from gem directory)
    
    $ bundle exec rake install

## Usage

Example usage:

    $cg1 tags cat,car,plain,tree,helicopter,yeti,fly,water,avatar,sky -o ~/album.jpg
    $cg1 tags cat
    
Or if you have problems installing gem

    $chmod +x ./exe/cg1
    $bundle exec ./exe/cg1 tags cat

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## TODO

+ Tests
+ Better configs
+ Deeper directory structure for easier scaling
+ To look into Flickr API to make number of queries less
+ Security, especially for file uploading
+ Refactor for scalability
+ CLI enhancments: Progress bar, colorification

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

