class UserSerializer < ActiveModel::Serializer
  attributes %w[id telegram_id first_name last_name username photo_url auth_date created_at
                updated_at]

  attribute :token, if: -> { @instance_options[:show_token] }
end
