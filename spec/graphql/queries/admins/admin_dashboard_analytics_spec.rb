require 'rails_helper'

RSpec.describe Queries::Admins::AdminDashboardAnalytics do
  let(:context) { { current_user: create(:admin) } }
  let(:variables) { {} }
  let(:query) do
    <<~GRAPHQL
      query {
        adminDashboardAnalytics {
          newUsersCount
          usersCount
          activeUsersCount
          revokedUsersCount
        }
      }
    GRAPHQL
  end

  subject(:result) do
    GraphqlBoilerplateSchema.execute(
      query,
      context: context,
      variables: variables
    )
  end

  context "Query" do
    it "returns the dashboard analytics" do
      expect(result.dig("data", "adminDashboardAnalytics", "newUsersCount")).not_to be_nil
      expect(result.dig("data", "adminDashboardAnalytics", "usersCount")).not_to be_nil
      expect(result.dig("data", "adminDashboardAnalytics", "activeUsersCount")).not_to be_nil
      expect(result.dig("data", "adminDashboardAnalytics", "revokedUsersCount")).not_to be_nil
    end

    it "returns no errors" do
      expect(result["errors"]).to be_nil
    end
  end
end
