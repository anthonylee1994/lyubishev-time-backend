class TimeEventTag < ApplicationRecord
  belongs_to :color
  belongs_to :user

  validates :name, presence: true
  validates :color, presence: true
end