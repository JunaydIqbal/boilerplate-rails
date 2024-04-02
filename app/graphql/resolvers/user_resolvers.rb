module Resolvers
  class UserResolvers

    def initialize(object)
      @object = object
    end

    def type
      # Convert it to the corresponding enum value
      case @object.type
      when "Users::SuperAdmin"
        "Super-Admin"
      when "Users::Admin"
        "Admin"
      when "Users::Assessor"
        "Assessor"
      when "Users::Client"
        "Client"
      else
        nil
      end
    end
  end
end
