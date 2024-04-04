module Queries
  module Admins
    class AllUsers < Queries::BaseQuery
      include AuthenticableApiUser
      include PermissionAuthenticator

      argument :type, Types::Users::UserTypeEnum, required: true, default_value: "ADMIN"
      argument :filter, Types::Filters::FilterAttributes, required: false
      argument :page, Integer, required: false, default_value: 1
      argument :per_page, Integer, required: false, default_value: 10
      argument :status, Types::Users::StatusEnum, required: false, default_value: "ALL_USERS"

      type Types::Users::UsersPagination, null: false

      def resolve(**params)
        authenticate_admin! 
        
        result = fetch_users(params)
        result.success? ? result.all_users : interactors_execution_error(result: result)
      rescue => e
        execution_error(message: e.message)
      end

      private

        def fetch_users(params)
          ::Admins::AllUsers.call(
            params: params.to_h
          )
        end
    end
  end
end