module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    field :fetch_user, resolver: Queries::Users::FetchUser
    
    # Admin fields
    field :admin_dashboard_analytics, resolver: Queries::Admins::AdminDashboardAnalytics
    field :all_users, resolver: Queries::Admins::AllUsers

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    # TODO: remove me
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World!"
    # end
  end
end
