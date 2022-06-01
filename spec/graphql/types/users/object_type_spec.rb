RSpec.describe Types::Users::ObjectType do
  
  context "Fields" do
    it "should validate nullability and types" do
      %w(id email firstName lastName phoneNo role).each do |attr|
        expect(described_class.fields).to include(attr)
        expect(described_class.fields[attr].type.class).to eq(GraphQL::Schema::NonNull)
        expect(described_class.fields[attr].type.of_type).to eq(
          attr == "id" ? GraphQL::Types::ID : GraphQL::Types::String
        )
      end
    end
  end

end
