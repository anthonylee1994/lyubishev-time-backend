class TimeEventSerializer < ActiveModel::Serializer
  attributes TimeEvent.attribute_names.map(&:to_sym)

  belongs_to :tag
end
