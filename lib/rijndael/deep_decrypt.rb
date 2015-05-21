##
# Include DeepDecrypter and implement decrypt(String) to make use of:
#   - decrypt_str
#   - decrypt_each
#   - decrypt_hash
#   - decrypt_deep
#
module DeepDecrypt
  def decrypt_deep(obj)
    case obj
    when String
      decrypt_str(obj)
    when Array
      decrypt_each(obj)
    when Hash
      decrypt_hash(obj)
    else
      obj
    end
  end

  def decrypt_str(str)
    str = str.dup
    if str =~ Rijndael::CIPHER_PATTERN
      decrypt(str)
    else
      str
    end
  end

  def decrypt_each(arr)
    res = arr.class.new
    arr.each do |v|
      res << decrypt_deep(v)
    end

    res
  end

  def decrypt_hash(hash)
    res = hash.class.new
    hash.each do |k, v|
      res[k] = decrypt_deep(v)
    end

    res
  end
end
