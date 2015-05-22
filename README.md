# Rijndael

Easily encrypt and decrypt strings using AES.

## Usage

First, you need to generate a new key, which is necessary for initializing the Rijndael::Base instance. Either use the
command line tool `rijndael -k` or plain ruby.

    $ gem install rijndael
    $ irb
    2.2.2 :001 > require 'rijndael'
    2.2.2 :002 > Rijndael::Base.generate_key
     => "hoqqk6kQuRa1GlDi7P31GLEVj3l4I+lpF8IGtG5mWQE="

Now you can use an instance of Rijndael::Base to `encrypt` and `decrypt` your stuff. The `decrypt_deep` method supports
instances of String, Array and Hash. It searches for the cipher pattern and tries to decrypt anything. The pattern looks
like this: `$IV$CIPHER`

The IV is the initialization vector for AES, which will be generated randomly while encrypting. CIPHER is the actual
cipher text.

    $ irb
    2.2.2 :001 > require 'rijndael'
    2.2.2 :002 > r = Rijndael::Base.new('hoqqk6kQuRa1GlDi7P31GLEVj3l4I+lpF8IGtG5mWQE=')
    2.2.2 :003 > r.encrypt('plain text')
     => "$sgqzGPPmH84Iw3VRqlv+FQ==$RYq4t6B3/vCUpzqKRwf+2g==" 
    2.2.2 :004 > r.decrypt('$sgqzGPPmH84Iw3VRqlv+FQ==$RYq4t6B3/vCUpzqKRwf+2g==')
     => "plain text" 

## Command Line Tool

Usage:

    rijndael -k
    rijndael (-e 'plain' | -d 'cipher')...
    rijndael -k key [-e 'plain' | -d 'cipher']...

Options:

    -k, --key [KEY]                  Generate or use key
    -e, --encrypt PLAIN              Encrypt plain text
    -d, --decrypt CIPHER             Decrypt cipher text
    -h, --help                       Print this help

**Attention!** Be careful when encrypting/decrypting. Do not forget to use single quotes. Otherwise your shell might try
to expand things like `~`, `$var` or similar.
