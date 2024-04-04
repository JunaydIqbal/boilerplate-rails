module Types
  module Users
    class StatusEnum < GraphQL::Schema::Enum
      value "ALL_USERS", "all_users"
      value "ACTIVE", "active"
      value "INACTIVE", "inactive"
      value "PENDING", "pending"
      value "ACCEPTED", "accepted"
    end
  end
end