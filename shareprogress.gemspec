Gem::Specification.new do |s|
  s.name = "shareprogress"
  s.version = "0.0.1"
  s.summary = "Ruby gem to communicate with ShareProgress API"
  s.description = s.summary
  s.authors = ["Cecilia Rivero"]
  s.email = ["contact@ceciliarivero.com"]
  s.homepage = "https://github.com/ceciliarivero/shareprogress-rb"
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")

  s.add_dependency "requests"
  s.add_dependency "scrivener"

  s.add_development_dependency "cuba"
  s.add_development_dependency "cuba-contrib"
  s.add_development_dependency "cutest"
end
