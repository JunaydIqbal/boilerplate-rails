module Types
  module Users
    class UpdateAttributes < Types::BaseInputObject
      argument :email, String, required: false, 
        validates: { format: { 
          with: /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
        }
      }
      argument :full_name, String, required: false
      argument :password, String, required: false
      argument :password_confirmation, String, required: false
    end
  end
end