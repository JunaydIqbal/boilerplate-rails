require 'rails_helper'

RSpec.describe Mutations::Users::LoginUser do
  context "Arguments" do
    it "should validate existence of #loginAttributes" do
      expect(described_class.arguments).to include("loginAttributes")
      expect(described_class.arguments["loginAttributes"].type.class).to eq(GraphQL::Schema::NonNull)
      expect(described_class.arguments["loginAttributes"].type.of_type).to eq(Types::Users::LoginAttributes)  
    end
  end

  context "Fields" do
    it "should respond to Types::Payloads::UserPayload" do
      expect(described_class.type).to eq(Types::Payloads::UserPayload)
    end
  end

  context "Methods" do
    describe "Private Methods" do
      it "should respond to :login_user" do
        expect(described_class.private_instance_methods).to include(:login_user)
      end
    end
  end
  

  context ".resolve" do
    let(:user) { create(:user) }

    let(:mutation) do
      <<~GQL
      mutation {
        loginUser(
          input: {
            loginAttributes: {
              email: "#{user.email}",
              password: "admin123",
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
      expect(result.dig("data", "loginUser", "token")).not_to be_nil
      expect(result.dig("data", "loginUser", "user", "id")).not_to be_nil
      expect(result.dig("data", "loginUser", "user", "email")).to eq(user.email)
    end    
  end
end
