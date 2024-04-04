module Types
  module Users
    class StatusEnum < GraphQL::Schema::Enum
      value "ALL", "all"
      value "ACTIVE", "active"
      value "INACTIVE", "inactive"
      value "PENDING", "pending"
      value "ACCEPTED", "accepted"
    end
  end
end