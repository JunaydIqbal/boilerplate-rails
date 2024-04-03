module Types
  module Users
    class BaseAttributes < Types::BaseInputObject
      # for now, we use the base attributes for sending invitation or add user with any role by administrator

      argument :email, String, required: true, 
        validates: { format: { 
          with: /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
        }
      }
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :type, Types::Users::UserTypeEnum, required: true

      # for now, we don't need phone_no and password arguments, maybe use in-future

      # argument :phone_no, String, required: false
      # argument :password, String, required: true
      # argument :password_confirmation, String, required: true
    end
  end
end