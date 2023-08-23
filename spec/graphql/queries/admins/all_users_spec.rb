require 'rails_helper'

RSpec.describe Queries::Admins::AllUsers do
  let(:context) { { current_user: create(:admin) } }
  let(:variables) { {} }
  let(:query) do
    <<~GRAPHQL
      query {
        allUsers(skipAdmin: true) {
          edges {
            node {
              id
              email
            }
          }
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
    before(:each) do
      create(:user)
    end
    
    it "returns a list of users" do
      expect(result.dig("data", "allUsers", "edges")).not_to be_empty
    end

    it "returns no errors" do
      expect(result["errors"]).to be_nil
    end
  end
end
