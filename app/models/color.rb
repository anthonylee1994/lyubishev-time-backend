class Color < ApplicationRecord
  has_many :time_event_tags, dependent: :destroy
end
