require 'rails_helper'

RSpec.describe Mutations::Admins::ModifyAccessUser do
  let(:context) { { current_user: create(:admin) } }
  let(:user) { create(:user) }
  let(:mutation) do
    <<~GRAPHQL
      mutation {
        modifyAccessUser(
          input: {
            accessAttributes: {
              userId: "#{user.id}",
              revokeAccess: true
            }
          }
        ) {
          email
          revokeAccess
          deleted
        }
      }
    GRAPHQL
  end

  subject(:result) do
    GraphqlBoilerplateSchema.execute(
      mutation,
      context: context
    )
  end

  context "Mutation" do
    it "returns the modified user with updated access level" do
      expect(result.dig("data", "modifyAccessUser", "email")).to eq(user.email)
      expect(result.dig("data", "modifyAccessUser", "revokeAccess")).to eq(true)
    end

    it "returns no errors" do
      expect(result["errors"]).to be_nil
    end
  end
end
