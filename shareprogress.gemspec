Gem::Specification.new do |s|
  s.name = "shareprogress"
  s.version = "1.0.0"
  s.summary = "Ruby gem to communicate with ShareProgress API"
  s.description = s.summary
  s.authors = ["SumOfUs"]
  s.email = ["info@sumofus.org"]
  s.homepage = "https://github.com/SumOfUs/shareprogress"
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")

  s.add_dependency "requests"
  s.add_dependency "scrivener"
  s.add_development_dependency "cuba"
  s.add_development_dependency "cuba-contrib"
  s.add_development_dependency "cutest"
end
