class TimeEventTagSerializer < ActiveModel::Serializer
  attributes %w[id color_id name user_id order created_at updated_at]

  belongs_to :color
end
