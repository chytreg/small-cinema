module ApiKeys
  class Create < UseCase
    arguments :email, :password

    def execution
      raise UnauthorizedAccessError, "Unauthorized access" unless user&.authenticate(password)

      api_token = user.api_keys.create! token_digest: token_digest
      {id: api_token.id, token: token}
    end

    private

    def user
      @user ||= User.find_by email: email
    end

    def token
      @token ||= SecureRandom.hex
    end

    def token_digest
      OpenSSL::HMAC.hexdigest "SHA256", ApiKey::HMAC_SECRET_KEY, token
    end
  end
end
