module Types
  module Users
    class ProfileAttributes < Types::BaseInputObject
      argument :email, String, required: false, 
        validates: { format: { 
          with: /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
        }
      }
      argument :first_name, String, required: false
      argument :last_name, String, required: false
      argument :phone_no, String, required: false
      argument :password, String, required: false
      argument :password_confirmation, String, required: false
      argument :profile_picture, ApolloUploadServer::Upload, required: false
    end
  end
end