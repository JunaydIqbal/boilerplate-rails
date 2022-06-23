module Types
  module Users
    class SetPasswordAttributes < Types::BaseInputObject
      argument :reset_password, Boolean, required: false
      argument :token, String, required: true
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
    end
  end
end