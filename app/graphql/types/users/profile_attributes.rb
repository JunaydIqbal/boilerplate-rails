module Types
  module Users
    class ProfileAttributes < Types::Users::UpdateAttributes
      argument :id, ID, required: true
      argument :profile_picture, ApolloUploadServer::Upload, required: false
    end
  end
end