module Types
  module Users
    class RegisterAttributes < Types::Users::BaseAttributes # That adds up common user attributes
      argument :remember_me, Boolean, required: true
    end
  end
end