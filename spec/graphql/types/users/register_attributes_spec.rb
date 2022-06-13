require 'rails_helper'

RSpec.describe Types::Users::RegisterAttributes do
  
  let(:email_regex) { /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/ }

  context "Arguments" do

    it "should validate existence of attrs and their types" do
      %w(email password passwordConfirmation rememberMe).each do |attr|
        expect(described_class.arguments).to include(attr)
        expect(described_class.arguments[attr].type.class).to eq(GraphQL::Schema::NonNull)
        expect(described_class.arguments[attr].type.of_type).to eq(
          attr == "rememberMe" ? GraphQL::Types::Boolean : GraphQL::Types::String
        )
      end
    end
    
    
    it "should validate format of #email" do
      expect(described_class.arguments["email"].validators).to include(GraphQL::Schema::Validator::FormatValidator)
      expect(described_class.arguments["email"].validators.first.instance_variable_get(:@with_pattern)).to eq(email_regex)
    end
  end

end
