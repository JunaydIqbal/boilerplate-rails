module Types
  module Users
    class BaseAttributes < Types::BaseInputObject
      argument :email, String, required: true, 
        validates: { format: { 
          with: /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
        }
      }
      argument :full_name, String, required: false
      argument :phone_no, String, required: false
      argument :password, String, required: true
      argument :password_confirmation, String, required: true
    end
  end
end