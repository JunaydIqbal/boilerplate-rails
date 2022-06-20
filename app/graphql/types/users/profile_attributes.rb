module Types
  module Users
    class ProfileAttributes < Types::Users::BaseAttributes
      argument :id, ID, required: true
      argument :image, ApolloUploadServer::Upload, required: false
    end
  end
end