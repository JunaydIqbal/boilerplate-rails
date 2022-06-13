require 'rails_helper'

RSpec.describe Types::Users::LoginAttributes do
  context "Arguments" do
    it "should validate existence of attrs and their types" do
      %w(email password rememberMe).each do |attr|
        expect(described_class.arguments).to include(attr)
        expect(described_class.arguments[attr].type.class).to eq(GraphQL::Schema::NonNull)
        expect(described_class.arguments[attr].type.of_type).to eq(
          attr == 'rememberMe' ? GraphQL::Types::Boolean : GraphQL::Types::String
        )
      end
    end
  end
end
