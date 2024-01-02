class JwtService
  def self.encode(payload)
    JWT.encode(camelize_key(payload), Rails.application.credentials.secret_key_base)
  end

  def self.decode(token)
    payload = JWT.decode(token, Rails.application.credentials.secret_key_base).first
    camelize_key(payload)
  rescue JWT::DecodeError
    raise Exceptions::InvalidToken
  end

  def self.camelize_key(payload)
    payload.deep_symbolize_keys(&:camel_case)
  end
end
