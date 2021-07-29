class ApiKey < ApplicationRecord
  belongs_to :bearer, polymorphic: true

  HMAC_SECRET_KEY = Rails.application.credentials.api_key_hmac_secret

  def serializable_hash(options = nil)
    super options.merge(except: "token_digest")
  end
end
