class MessageSerializer < ActiveModel::Serializer
  attributes :id, :conversation_id, :user_id, :text, :created_at
end
