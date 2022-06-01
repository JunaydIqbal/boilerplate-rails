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

end
