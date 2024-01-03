class TimeEventTagSerializer < ActiveModel::Serializer
  attributes %w[id color name order user_id]
end
