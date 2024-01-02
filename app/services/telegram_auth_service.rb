# frozen_string_literal: true

class TelegramAuthService
  def self.verify!(auth_data)
    check_hash = auth_data[:hash]
    auth_data = auth_data.slice(:auth_date, :first_name, :id, :last_name, :photo_url, :username)
    check_string = auth_data.map { |k, v| "#{k}=#{v}" }.sort.join("\n")

    secret_key = OpenSSL::Digest.new('SHA256').digest(Settings.telegram.bot_token)
    hash = OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('SHA256'), secret_key, check_string)

    raise StandardError, 'Data is NOT from Telegram' if hash.casecmp(check_hash) != 0

    true
  end
end
