module Mutations
  module Support
    # A dummy class to test GraphQL processes ..
    class OrderGenerator < GraphQL::Schema::Mutation
      include AuthenticableApiUser
    
      argument :number, Int
    
      field :errors, [String]
      field :number, Int
    
      def resolve(number:)
        { number: number }
      end
    end
  end  
end
