class RsvpSerializer < ActiveModel::Serializer
  attributes :id, :name, :attending, :message
end
