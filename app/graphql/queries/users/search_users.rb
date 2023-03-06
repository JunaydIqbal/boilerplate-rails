module Queries
  module Users
    class SearchUsers < Queries::BaseQuery
      include AuthenticableApiUser

      argument :search_keywords, Types::Filters::UserAttributes, required: true

      type Types::Users::ObjectType.connection_type, null: true

      def resolve(**params)
        users = User.search(params.dig(:search_keywords, :keyword))
      rescue => e
        execution_error(message: e.message)
      end
    end
  end
end