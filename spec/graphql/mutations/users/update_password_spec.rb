require 'rails_helper'

RSpec.describe Mutations::Users::UpdatePassword do
  let(:context) { { current_user: create(:user) } }
 
  let(:mutation) do
    <<~GRAPHQL
      mutation {
        updatePassword(
          input: {
            currentPassword: "admin123",
            password: "admin1234",
            passwordConfirmation: "admin1234"
          }
        ) {
          response
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
    it "returns a successful response after updating the password" do
      expect(result.dig("data", "updatePassword", "response")).to eq(true)
    end

    it "returns no errors" do
      expect(result["errors"]).to be_nil
    end
  end
end
