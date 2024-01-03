class TimeEventTagSerializer < ActiveModel::Serializer
  attributes TimeEventTag.attribute_names.map(&:to_sym)

  belongs_to :color
end
