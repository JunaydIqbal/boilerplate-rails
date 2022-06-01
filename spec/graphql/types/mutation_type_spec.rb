# frozen_string_literal: true

RSpec.describe Types::MutationType do
  
  context "Registered fields" do
    it "should check inclusion of #registerUser" do
      expect(described_class.fields.has_key?("registerUser")).to be(true)
      expect(described_class.fields["registerUser"].mutation).to eq(Mutations::Users::RegisterUser)
    end
  end

end