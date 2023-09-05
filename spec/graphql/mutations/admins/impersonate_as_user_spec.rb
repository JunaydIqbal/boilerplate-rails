require 'rails_helper'

RSpec.describe Mutations::Admins::ImpersonateAsUser do
  context "Arguments" do
    it "should validate existence of #userId" do
      expect(described_class.arguments).to include("userId")
      expect(described_class.arguments["userId"].type.of_type).to eq(GraphQL::Types::ID)
      expect(described_class.arguments["userId"].type.class).to eq(GraphQL::Schema::NonNull)
    end
  end

  context "Fields" do
    it "should respond to #impersonatedToken and #user" do
      expect(described_class.fields).to include("impersonatedToken")
      expect(described_class.fields).to include("user")

      impersonated_token_field = described_class.fields["impersonatedToken"]
      user_field = described_class.fields["user"]

      expect(impersonated_token_field.type.of_type).to eq(GraphQL::Types::String)
      expect(impersonated_token_field.type.class).to eq(GraphQL::Schema::NonNull)

      expect(user_field.type.of_type).to eq(Types::Users::ObjectType)
      expect(impersonated_token_field.type.class).to eq(GraphQL::Schema::NonNull)
    end
  end

  context ".resolve" do
    
    let(:user) { create(:admin) }
    let(:user_to_impersonate) { create(:user) }
    
    let(:mutation) do
      <<~GQL
      mutation {
        impersonateAsUser(
          input: {
              userId: "#{user_to_impersonate.id}"
            }
          ) {
            impersonatedToken
            user {
              id
              email
            }
          }
        }
      GQL
    end

    subject(:result) do
      GraphqlBoilerplateSchema.execute(mutation, context: { current_user: user })
    end

    it "should resolve the mutation and return #user and #impersonatedToken" do
      expect(result.dig("data", "impersonateAsUser", "impersonatedToken")).not_to be_nil
      expect(result.dig("data", "impersonateAsUser", "user", "id")).not_to be_nil
      expect(result.dig("data", "impersonateAsUser", "user", "email")).to eq(user_to_impersonate.email)
    end
  end
end
