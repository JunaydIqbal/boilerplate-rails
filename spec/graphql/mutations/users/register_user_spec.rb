require 'rails_helper'

RSpec.describe Mutations::Users::RegisterUser do
  context "Arguments" do
    it "should validate existence of #registerAttributes" do
      expect(described_class.arguments).to include("registerAttributes")
      expect(described_class.arguments["registerAttributes"].type.class).to eq(GraphQL::Schema::NonNull)
      expect(described_class.arguments["registerAttributes"].type.of_type).to eq(Types::Users::RegisterAttributes)  
    end
  end

  context "Fields" do
    it "should respond to Types::Payloads::UserPayload" do
      expect(described_class.type).to eq(Types::Payloads::UserPayload)
    end
  end

  context "Methods" do
    describe "Private Methods" do
      it "should respond to :register_user" do
        expect(described_class.private_instance_methods).to include(:register_user)
      end      
    end
  end
  

  context ".resolve" do
    let(:mutation) do
      <<~GQL
      mutation {
        registerUser(
          input: {
            registerAttributes: {
              email: "user@example.com",
              password: "admin123",
              passwordConfirmation: "admin123",
              rememberMe: false
            }
          }
        ) {
          token
          user {
            id
            email
          }
        }
      }
      GQL
    end

    subject(:result) do
      GraphqlBoilerplateSchema.execute(mutation)
    end

    it "should resolve the mutation and return #user and #token" do
      expect(result.dig("data", "registerUser", "token")).not_to be_nil
      expect(result.dig("data", "registerUser", "user", "id")).not_to be_nil
      expect(result.dig("data", "registerUser", "user", "email")).to eq("user@example.com")
    end    
  end
end
