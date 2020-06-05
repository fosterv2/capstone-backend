class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :owner_name, :breed, :img_url
end
