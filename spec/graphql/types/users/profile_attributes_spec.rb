require 'rails_helper'

RSpec.describe Types::Users::ProfileAttributes do
  context "Config" do
    it "should check for parent class" do
      expect(described_class.superclass).to eql(Types::Users::UpdateAttributes) 
    end
  end

  context "Arguments" do
    it "should validate existence of attrs and their types" do
      # Add more attributes inside collection to validate!
      %w(id image).each do |attr|
        expect(described_class.arguments).to include(attr)
        # expect(described_class.arguments[attr].type.class).to eq(GraphQL::Schema::NonNull)

        if attr == "image"
          expect(described_class.arguments[attr].type).to eq(ApolloUploadServer::Upload)
        else
          # Adjust this logic according to type of argument
          # attr == "id" ? GraphQL::Types::ID : ApolloUploadServer::Upload
          expect(described_class.arguments[attr].type.of_type).to eq(GraphQL::Types::ID)
        end
      end
    end
  end
end