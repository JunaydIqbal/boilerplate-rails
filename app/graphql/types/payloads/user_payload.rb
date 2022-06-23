module Types
  module Payloads
    class UserPayload < Types::BaseObject
      field :token, String, null: false
      field :user, Types::Users::ObjectType, null: false
    end
  end
end