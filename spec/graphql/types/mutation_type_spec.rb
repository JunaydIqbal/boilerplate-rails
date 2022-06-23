# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Types::MutationType do
  let(:fields_mapper) do
    {
      'registerUser' => Mutations::Users::RegisterUser,
      'loginUser' => Mutations::Users::LoginUser,
      'updateUser' => Mutations::Users::UpdateUser
    }
  end
  
  context "Registered fields" do
    it "should check inclusion of fields" do
      fields_mapper.each do |field, klass|
        expect(described_class.fields.has_key?(field)).to be(true)
        expect(described_class.fields[field].mutation).to eq(klass)
      end
    end
  end

end