module Types
  module Users
    class UserTypeEnum < GraphQL::Schema::Enum
      value "ADMIN", "Users::admin"
      value "ASSESSOR", "Users::Assessor"
      value "CLIENT", "Users::Client"
    end
  end
end