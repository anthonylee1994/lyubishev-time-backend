class User < ApplicationRecord
  validates :telegram_id, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :username, presence: true, uniqueness: true, allow_nil: true
end
