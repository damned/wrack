Gem::Specification.new do |s|
  s.name = 'wrack'
  s.version = "0.0.2"
  s.date = '2013-08-22'
  s.authors = 'damned'
  s.summary = 'webserver using rack'
  s.files = [
    "Gemfile",
    "lib/wrack.rb"
  ]
  s.add_dependency 'rack'
  s.add_dependency 'thin'
end
