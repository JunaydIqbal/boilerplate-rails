module Types
  module Admins
    class DashboardAnalytics < Types::BaseObject
      field :new_users_count, Int, null: false
      field :users_count, Int, null: false
      field :active_users_count, Int, null: false
      field :revoked_users_count, Int, null: false
    end
  end
end