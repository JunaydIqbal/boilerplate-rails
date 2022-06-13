module Types
  module Users
    class RegisterAttributes < Types::BaseInputObject
      argument :email, String, required: true, 
        validates: { format: { 
          with: /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
        } 
      }
      
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
      argument :remember_me, Boolean, required: true
    end
  end
end