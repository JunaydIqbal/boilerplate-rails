module Queries
  module Admins
    class AllUsers < Queries::BaseQuery
      include AuthenticableApiUser
      include PermissionAuthenticator

      argument :skip_admin, Boolean, required: true
      argument :filter, Types::Filters::UserAttributes, required: false

      type Types::Users::ObjectType.connection_type, null: true

      def resolve(**params)
        authenticate_admin!
        
        users = User.search(params.dig(:filter, :keyword))
        params[:skip_admin] ? users.user : users
      rescue => e
        execution_error(message: e.message)
      end
    end
  end
end