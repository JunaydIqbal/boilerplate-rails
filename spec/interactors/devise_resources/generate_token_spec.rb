require 'rails_helper'

RSpec.describe DeviseResources::GenerateToken do
  context "Constants" do
    it "should have #SECRET_KEY" do
      expect(described_class.constants).to include(:SECRET_KEY)
    end
  end

  context "Delegate Attrs" do
    it "should have #resource, #resource_id as a public instance methods" do
      %i(resource resource_id).each do |attr|
        expect(described_class.public_instance_methods).to include(attr)
      end
    end
  end

  context "Methods" do
    let(:user) { build(:user) }
    let(:token_interactor) { described_class.new(resource: user) }

    describe "Public" do
      describe "Existence" do
        it "should have implemented #call" do
          expect(described_class.public_instance_methods).to include(:call)
        end
      end
      
      describe "Functionality" do
        it "should check #call" do
          expect(token_interactor).to receive(:generate_token)
          token_interactor.call
        end
      end      
    end

    describe "Private" do
      describe "Existence" do  
        before(:each) do
          @token_interactor = described_class.new  
        end

        it "should have implemented #generate_token, #expiration_limit, #expiry_time, #payload" do
          %i(generate_token expiration_limit expiry_time payload).each do |method|
            expect(@token_interactor.respond_to?(method, true)).to eq(true)
          end
        end
      end

      describe "Functionality" do
        def grab_time_difference(time_with_zone)
          ((time_with_zone.to_time - Time.now) / 3600).round
        end

        it "should check #payload" do
          expect(token_interactor.send(:payload).keys).to eql([:sub, :exp, :role])
        end

        it "should check #expiry_time" do
          expect(token_interactor).to receive(:expiration_limit)
          token_interactor.send(:expiry_time)
        end

        it "should check #expiration_limit" do
          res = token_interactor.send(:expiration_limit)
          time_diff = grab_time_difference(res)
          expect(res).to be_instance_of(ActiveSupport::TimeWithZone)
          expect(time_diff).to eq(24)
        end

        it "should check #expiration_limit when remember_me is enabled" do
          token_interactor.context.remember_me = true
          res = token_interactor.send(:expiration_limit)
          time_diff = grab_time_difference(res)
          expect(time_diff).to eq(336)
        end

        it "should check #generate_token" do
          token = token_interactor.send(:generate_token)
          payload, enc_algorithm = JWT.decode(token, nil, false)
          
          expect(payload["role"]).to eql("user")
          expect(enc_algorithm["alg"]).to eql("HS256")
        end

        it "should rescue StandardError for #generate_token" do
          allow(token_interactor).to receive(:payload).and_raise(StandardError, "Bad payload!")
          expect{ token_interactor.send(:generate_token) }.to raise_error(StandardError)
          expect(token_interactor.context.error).to eq("Bad payload!")
          expect(token_interactor.context).not_to be_a_success
        end
      end
    end
  end
end
