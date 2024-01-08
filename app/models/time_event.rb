class TimeEvent < ApplicationRecord
  belongs_to :tag, class_name: 'TimeEventTag', foreign_key: 'tag_id'
  belongs_to :user

  has_one :color, through: :tag

  scope :one_year_ago, -> { where(date: 1.year.ago..Time.zone.today) }
  scope :load_children_with_date_order, -> { includes(:tag, :color).order(date: :desc, order: :desc) }
  scope :load_children_with_order, -> { includes(:tag, :color).order(order: :asc) }

  validates :name, presence: true
  validates :date, presence: true
end
