module Types
  module Users
    class UserTypeEnum < GraphQL::Schema::Enum
      value "ADMIN", "Users::Admin"
      value "ASSESSOR", "Users::Assessor"
      value "CLIENT", "Users::Client"
    end
  end
end