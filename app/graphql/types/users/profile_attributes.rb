module Types
  module Users
    class ProfileAttributes < Types::Users::BaseAttributes
      argument :image, ApolloUploadServer::Upload, required: false
    end
  end
end