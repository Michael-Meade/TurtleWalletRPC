require_relative 'lib/TurtleCoins/version'

Gem::Specification.new do |spec|
  spec.name          = "TurtleCoin"
  spec.version       = TurtleCoin::VERSION
  spec.authors       = ["Michael-Meade"]
  spec.email         = ["this_is_dumb@gmail.com"]

  spec.summary       = %q{123}
  spec.description   = %q{lll}
  spec.homepage      = "https://google.com"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage


  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
