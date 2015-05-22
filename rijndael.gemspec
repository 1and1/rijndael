require_relative 'lib/rijndael/version'

GEM_SPEC = Gem::Specification.new do |s|
  s.name        = 'rijndael'
  s.version     = Rijndael::VERSION
  s.author      = 'Finn Glöe'
  s.email       = 'finn.gloee@1und1.de'
  s.summary     = 'Easily encrypt and decrypt strings using AES.'
  s.description = 'Easily encrypt and decrypt strings using AES. Rijndael is a wrapper around OpenSSL::Cipher to ' +
                  'abstract to a minimum of needed methods.'
  s.homepage    = 'https://github.com/1and1/rijndael'
  s.license     = 'GPL v2'

  s.files       = Dir['lib/**/*']
  s.executables = 'rijndael'

  s.required_ruby_version = '~> 2.0'

  s.add_development_dependency 'rake', '~> 10.4'
  s.add_development_dependency 'minitest', '~> 5.6'
end
