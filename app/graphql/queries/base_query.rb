module Queries
  class BaseQuery < GraphQL::Schema::Resolver
    include ExecutionErrorResponder
    include InteractorErrorHandler
  end
end