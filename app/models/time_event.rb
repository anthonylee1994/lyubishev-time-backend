class TimeEvent < ApplicationRecord
  belongs_to :tag, class_name: 'TimeEventTag', foreign_key: 'tag_id'
  belongs_to :user

  has_one :color, through: :tag

  validates :name, presence: true
  validates :date, presence: true
end
