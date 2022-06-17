require 'rails_helper'

RSpec.describe Types::Users::ProfileAttributes do
  context "Config" do
    it "should check for parent class" do
      expect(described_class.superclass).to eql(Types::Users::BaseAttributes) 
    end
  end

  context "Arguments" do
    it "should validate existence of attrs and their types" do
      # Add more attributes inside collection to validate!
      %w(image).each do |attr|
        expect(described_class.arguments).to include(attr)
        # expect(described_class.arguments[attr].type.class).to eq(GraphQL::Schema::NonNull)
        expect(described_class.arguments[attr].type).to eq(
          ApolloUploadServer::Upload
          # Adjust this logic according to type of argument
          # attr == "rememberMe" ? GraphQL::Types::Boolean : GraphQL::Types::String
        )
      end
    end
  end

end