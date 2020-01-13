require 'jwt'

module VeteranVerification
  class Notary
    attr_reader :payload

    def initialize(private_key_path)
      key_file = File.read(private_key_path)
      @rsa_private = OpenSSL::PKey::RSA.new(key_file)
    end

    def sign(payload)
      signed_token = JWT.encode(payload, @rsa_private, 'RS256')
    end
  end
end
