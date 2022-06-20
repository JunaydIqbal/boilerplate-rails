require "rails_helper"

RSpec.describe Mutations::Users::UpdateUser do
  context "Arguments" do
    it "should validate existence of #profileAttributes" do
      expect(described_class.arguments).to include("profileAttributes")
      expect(described_class.arguments["profileAttributes"].type.class).to eq(GraphQL::Schema::NonNull)
      expect(described_class.arguments["profileAttributes"].type.of_type).to eq(Types::Users::ProfileAttributes)
    end
  end

  context "Fields" do
    it "should respond to Types::Users::ObjectType" do
      expect(described_class.type).to eq(Types::Users::ObjectType) 
    end
  end
  
  context "Methods" do
    describe "Private" do
      it "should respond to #update_user" do
        expect(described_class.private_instance_methods).to include(:update_user)
      end
    end
  end

  context ".resolve" do
    let(:user) { create(:user) }

    let(:mutation) do
      <<~GQL
      mutation($input: UpdateUserInput!) {
        updateUser(
          input: $input
        ) {
          id
          email
          imageUrl
        }
      }
      GQL
    end

    let(:image_obj) do
      ::ApolloUploadServer::Wrappers::UploadedFile.new(
        ActionDispatch::Http::UploadedFile.new(
          filename: "1634631002642",
          type: "image/jpeg",
          tempfile: File.new(
            "spec/support/files/1634631002642.jpeg"
          )
        )
      )
    end 

    let(:variables) do
      {
        input: {
          profileAttributes: {
            id: user.id,
            email: "edited@example.com",
            image: image_obj,
            password: "admin123",
            passwordConfirmation: "admin123"
          }
        }
      }
    end

    subject(:result) do
      GraphqlBoilerplateSchema.execute(mutation, variables: variables, context: { current_user: user })
    end

    it "should resolve the mutation and return #user" do
      expect(result.dig("data", "updateUser", "email")).to eq("edited@example.com")
      expect(result.dig("data", "updateUser", "imageUrl")).not_to be_nil
    end
  end
end
