module Types
  module Users
    class LoginAttributes < Types::BaseInputObject
      argument :email, String
      argument :password, String, required: true
    end
  end
end