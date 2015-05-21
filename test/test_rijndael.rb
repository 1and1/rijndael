require_relative 'test_helper'

# Test Crypt functionality
class TestCrypt < Minitest::Test
  def setup
    @crypt = Rijndael::Base.new('7xnfakb9k1xKWsoUWUtXhGR9qsG+tkdOXdvKGbRkXGY=')
  end

  def test_loading_empty_key_should_fail
    ex = assert_raises ArgumentError do
      Rijndael::Base.new(nil)
    end
    assert_equal 'Key is empty.', ex.message

    ex = assert_raises ArgumentError do
      Rijndael::Base.new('')
    end
    assert_equal 'Key is empty.', ex.message
  end

  def test_encryption
    e = @crypt.encrypt('plain text')
    assert_match Rijndael::CIPHER_PATTERN, e
  end

  def test_decryption
    d = @crypt.decrypt('$lCNNFWadM6/QIfbdAWJP/g==$oCUTE1bRE2Z7jNM0bRNs4A==')
    assert_equal 'plain text', d
  end

  def test_failing_enryption_should_raise
    ex = assert_raises ArgumentError do
      @crypt.decrypt('foobar')
    end
    assert_equal 'Cipher text has an unsupported format.', ex.message
  end

  def test_deep_decryption_str
    d = @crypt.decrypt_deep('$lCNNFWadM6/QIfbdAWJP/g==$SCzLNbG700CIzFifl9yzeg==')
    assert_equal 'deep text', d
  end

  def test_deep_decryption_array
    d = @crypt.decrypt_deep(%w(plain $lCNNFWadM6/QIfbdAWJP/g==$SCzLNbG700CIzFifl9yzeg== text))
    assert d.include?('deep text')
  end

  def test_deep_decryption_hash
    d = @crypt.decrypt_deep(
        key: 'value',
        cipher: '$lCNNFWadM6/QIfbdAWJP/g==$SCzLNbG700CIzFifl9yzeg=='
    )
    assert_equal 'deep text', d[:cipher]
  end

  def test_deep_decryption_complex
    d = @crypt.decrypt_deep(
        key: 'value',
        hash: {
          array: %w(plain $lCNNFWadM6/QIfbdAWJP/g==$SCzLNbG700CIzFifl9yzeg== text),
          time: Time.now
        }
    )
    assert d[:hash][:array].include?('deep text')
  end
end
