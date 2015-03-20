Gem::Specification.new do |s|
  s.name = "shareprogress"
  s.version = "0.0.2"
  s.summary = "Ruby gem to communicate with ShareProgress API"
  s.description = s.summary
  s.authors = ["Cecilia Rivero"]
  s.email = ["contact@ceciliarivero.com"]
  s.homepage = "https://github.com/ceciliarivero/shareprogress-rb"
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")

  s.add_runtime_dependency "requests", "~> 0"
  s.add_runtime_dependency "scrivener", "~> 0"

  s.add_development_dependency "cutest", "~> 0"
end
