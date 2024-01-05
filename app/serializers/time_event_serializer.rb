class TimeEventSerializer < ActiveModel::Serializer
  attributes %w[id name minute date order tag_id user_id created_at updated_at]

  belongs_to :tag
  has_one :color, through: :tag
end
