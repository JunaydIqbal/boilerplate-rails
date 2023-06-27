require 'rails_helper'

# Below class is used to test methods of AuthenticableApiUser module
require './spec/support/resources/order_generator'

RSpec.describe AuthenticableApiUser do
  let(:user) { create(:user) }
  let(:query) { 'mutation { orderGenerator( number: 1 ) { number } }' }
  let(:result) { GraphqlBoilerplateSchema.execute(query) }
  let(:result_1) { GraphqlBoilerplateSchema.execute(query, context: { current_user: user }) }

  context "Methods" do
    it "should check #ready?" do
      puts result
      expect(result["errors"][0]["message"]).to eql("Unauthorized error")
    end

    it "should check #ready? when #current_user is present" do
      puts result_1
      expect(result_1.dig('data', 'orderGenerator', 'number')).to eq(1)
    end

    it "should check #execution_error" do
      expect(Order.new.send(:unauthorized_error)).to be_instance_of(GraphQL::ExecutionError)
    end
  end
end