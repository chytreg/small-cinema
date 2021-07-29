module ApiKeys
  class Authenticate < UseCase
    arguments :token

    def execution
      ApiKey.find_by(token_digest: token_digest) ||
        raise(UnauthorizedAccessError, "Unauthorized access")
    end

    private

    def token_digest
      OpenSSL::HMAC.hexdigest "SHA256", ApiKey::HMAC_SECRET_KEY, token
    end
  end
end
