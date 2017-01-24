# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'photo_flick/version'

Gem::Specification.new do |spec|
  spec.name          = "photo_flick"
  spec.version       = PhotoFlick::VERSION
  spec.authors       = ["Sunil Antony"]
  spec.email         = ["chackoantonydaniel@gmail.com"]

  spec.summary       = %q{Coverts Flickr searched images to collage}
  spec.description   = %q{PhotoFlick is Ruby gem with which you can create image 
                          collages from Flickr images. You just need to provide some 
                          search keywords and PhotoFlick will search through Flickr 
                          to get images and create collage for you. }
  spec.homepage      = "https://github.com/chackoantony/photoflick"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = ['photoflick']
  spec.require_paths = ["lib"]

  spec.add_dependency 'flickraw'
  spec.add_dependency 'mini_magick'

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "webmock"
end
