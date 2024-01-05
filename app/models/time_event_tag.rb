class TimeEventTag < ApplicationRecord
  belongs_to :color
  belongs_to :user

  has_many :time_events, dependent: :destroy, foreign_key: 'tag_id'

  validates :name, presence: true

  scope :load_children_with_order, -> { includes(:color).order(:order) }
end
