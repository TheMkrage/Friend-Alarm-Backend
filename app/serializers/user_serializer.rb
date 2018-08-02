class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :facebook_connection
end
