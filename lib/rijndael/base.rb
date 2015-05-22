require 'openssl'
require 'base64'
require 'yaml'
require 'rijndael/deep_decrypt'

#:nodoc:
module Rijndael
  CIPHER_PATTERN = %r(^\$([a-zA-Z0-9+/]+={0,2})\$([a-zA-Z0-9+/]+={0,2})$)

  ##
  # Simply encrypt and decrypt strings using Rijndael.
  #
  class Base
    include DeepDecrypt

    ##
    # This constructor sets the de-/encryption key.
    #
    # @param key [String] Encryption key.
    #
    def initialize(key)
      @key = key
      fail ArgumentError, 'Key is empty.' if key.nil? || key.empty?
    end

    ##
    # This method expects a plain text of arbitrary length and encrypts it.
    #
    # @param plain [String] Plain text.
    #
    # @return [String] Cipher text.
    #
    def encrypt(plain)
      fail ArgumentError, 'No plain text supplied.' if plain.nil? || plain.empty?

      cipher = self.class.cipher
      cipher.encrypt
      cipher.key = Base64.decode64(@key)
      cipher.iv = iv = cipher.random_iv
      encrypted = cipher.update(plain)
      encrypted << cipher.final

      iv = Base64.strict_encode64(iv)
      encrypted = Base64.strict_encode64(encrypted)

      "$#{iv}$#{encrypted}"
    end

    ##
    # This method expects a base64 encoded cipher text and decrypts it.
    #
    # @param encrypted [String] Cipher text.
    #
    # @return [String] Plain text.
    #
    def decrypt(encrypted)
      fail ArgumentError, 'No cipher text supplied.' if encrypted.nil? || encrypted.empty?

      matches = CIPHER_PATTERN.match(encrypted)

      fail ArgumentError, 'Cipher text has an unsupported format.' if matches.nil?

      cipher = self.class.cipher
      cipher.decrypt
      cipher.key = Base64.decode64(@key)
      cipher.iv = Base64.decode64(matches[1])
      decrypted = cipher.update(Base64.decode64(matches[2]))

      decrypted << cipher.final
    end

    ##
    # Generate a random key for encryption.
    #
    # @return [String] Encryption key.
    #
    def self.generate_key
      Base64.strict_encode64(cipher.random_key)
    end

    def self.cipher
      @cipher ||= OpenSSL::Cipher.new 'aes-256-cbc'
    end
  end
end
