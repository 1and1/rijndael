require_relative 'lib/rijndael/version'

GEM_SPEC = Gem::Specification.new do |s|
  s.name       = 'rijndael'
  s.version    = Rijndael::VERSION
  s.author     = 'Finn Glöe'
  s.email      = 'finn.gloee@1und1.de'
  s.summary    = 'Easily encrypt and decrypt strings using AES.'

  s.files       = Dir['lib/**/*']
  s.test_files  = Dir['test/*']
  s.executables = 'rijndael'

  s.require_path  = 'lib'

  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
end