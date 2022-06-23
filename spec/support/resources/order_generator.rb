# A dummy class to test #execution_error
class Order
  include AuthenticableApiUser
end

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

# Register new mutation class inside MutationType
module Types
  class MutationType < Types::BaseObject
    field :order_generator, mutation: OrderGenerator
  end
end
