module Types
  module Users
    class LoginAttributes < Types::BaseInputObject
      argument :email, String
      argument :password, String, required: true
      argument :remember_me, Boolean, required: true
    end
  end
end