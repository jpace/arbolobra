# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "arbolobra/version"

Gem::Specification.new do |spec|
  spec.name          = "arbolobra"
  spec.version       = Arbolobra::VERSION
  spec.authors       = ["Jeff Pace"]
  spec.email         = ["jeugenepace@gmail.com"]

  spec.summary       = %q{Reads and writes a tree.}
  spec.description   = %q{Converts flat output to a hierarchy, and outputs with nested sections.}
  spec.homepage      = "http://www.github.com/jpace/arbolobra"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", "~> 3.1.5"
  spec.add_development_dependency "paramesan", "~> 0.1.1"
  spec.add_development_dependency "logue", "~> 1.0"
end
