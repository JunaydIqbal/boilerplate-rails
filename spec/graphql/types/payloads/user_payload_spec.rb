RSpec.describe Types::Payloads::UserPayload do
  
  context "Fields" do

    it "should validate nullability and type of #token" do
      expect(described_class.fields).to include("token")
      expect(described_class.fields["token"].type.of_type).to eq(GraphQL::Types::String)
    end

    it "should validate nullability and type of #user" do
      expect(described_class.fields).to include("user")
      expect(described_class.fields["user"].type.of_type).to eq(Types::Users::ObjectType)
    end
    
  end

end
