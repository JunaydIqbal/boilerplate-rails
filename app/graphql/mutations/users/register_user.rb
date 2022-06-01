module Mutations
  module Users
    class RegisterUser < BaseMutation
      argument :register_attributes, Types::Users::RegisterAttributes, required: true

      type Types::Payloads::UserPayload
    end
  end
end