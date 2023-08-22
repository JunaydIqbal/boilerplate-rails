module Queries
  module Admins
    class AdminDashboardAnalytics < Queries::BaseQuery
      include AuthenticableApiUser
      include AuthenticateAdmin

      type Types::Admins::DashboardAnalytics, null: false

      def resolve(**params)
        authenticate_admin!
        
        ::Admins::DashboardAnalytics.call
      rescue => e
        execution_error(message: e.message)
      end
    end
  end
end