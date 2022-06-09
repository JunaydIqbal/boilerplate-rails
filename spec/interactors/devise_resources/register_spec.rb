require 'rails_helper'

RSpec.describe DeviseResources::Register do
  context "Methods" do
    let(:register_obj) { described_class.new(resource_params: attributes_for(:user)) }
    let(:user) { build(:user) }
    let(:resource) { register_obj.send(:initialize_resource) }
    let(:set_resource) { register_obj.instance_variable_set(:@resource, resource) }
    let(:set_token_interactor) { register_obj.instance_variable_set(:@token_interactor, register_obj.send(:generate_token)) }

    describe "Public" do
      it "should have implemented #call" do
        set_resource        
        expect(described_class.respond_to?(:call)).to be(true) 
        expect(register_obj).to receive(:initialize_resource)
        expect(register_obj).to receive(:persist_resource_and_respond)
        
        register_obj.call
      end
    end

    describe "Private" do
      describe "Existence" do
        it "should have implemented #initialize_resource, #generate_token, 
          #check_token_response!, #persist_resource_and_respond" do
          %i(initialize_resource generate_token check_token_response! 
            persist_resource_and_respond).each do |method|
            expect(register_obj.respond_to?(method, true)).to be(true)
          end
        end
      end

      describe "Functionality" do
        before do |example|
          set_resource unless example.metadata[:skip_resource]
          set_token_interactor unless example.metadata[:skip_token]
        end

        it "should check #initialize_resource", skip_resource: true, skip_token: true do
          expect(resource).to be_instance_of(User)
          expect(resource.email).to eql('john@example.com')
        end

        it "should check #generate_token", skip_token: true do
          expect(register_obj.send(:generate_token).success?).to be(true)
        end

        it "should check #check_token_response!" do
          token_interactor = register_obj.instance_variable_get(:@token_interactor)
          expect(token_interactor.success?).to be(true)
          expect(token_interactor).to respond_to(:token)

          response = register_obj.send(:check_token_response!)
          expect(response).to be_instance_of(String)
        end

        it "should fail the context for #check_token_response!", skip_resource: true do
          allow(register_obj.instance_variable_get(:@token_interactor)).to receive(:success?).and_return(false)
          expect { register_obj.send(:check_token_response!) }.to raise_error(Interactor::Failure)
        end

        it "should check #persist_resource_and_respond" do
          response = register_obj.send(:persist_resource_and_respond)
          expect(register_obj.context.resource.persisted?).to be(true)
        end

        it "should should fail the context for #persist_resource_and_respond", skip_token: true do
          allow(resource).to receive(:save).and_return(false)
          expect { register_obj.send(:persist_resource_and_respond) }.to raise_error(Interactor::Failure)
        end
      end
    end
  end
end