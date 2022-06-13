require 'rails_helper'

RSpec.describe DeviseResources::Login do
  context "Methods" do
    let(:login_obj) do 
      described_class.new(
        resource_params: attributes_for(:user).except(
          :id, :password_confirmation, :first_name, :last_name
        ), klass: 'User'
      )
    end

    let!(:user) { create(:user) }
    let(:resource) { login_obj.send(:grab_resource) }
    let(:set_resource) { login_obj.instance_variable_set(:@resource, resource) }

    describe "Public" do
      it "should have implemented #call" do
        set_resource        
        expect(described_class.respond_to?(:call)).to be(true) 
        expect(login_obj).to receive(:grab_resource)
        expect(login_obj).to receive(:authenticate!)
        
        login_obj.call
      end
    end

    describe "Private" do
      describe "Existence" do
        it "should have implemented #grab_resource, #resource_name and #authenticate!" do
          %i(grab_resource authenticate!).each do |method|
            expect(login_obj.respond_to?(method, true)).to be(true)
          end
        end
      end

      describe "Functionality" do
        before do |example|
          set_resource unless example.metadata[:skip_resource]
        end

        it "should check #grab_resource" do
          expect(resource).to be_instance_of(User)
          expect(resource.email).to eql('john@example.com')
        end

        it "should check #resource_name" do
          expect(login_obj.send(:resource_name)).to eql(login_obj.context.klass.downcase)
        end

        it "should check #authenticate!" do
          result = login_obj.send(:authenticate!)
          
          expect(login_obj.context.success?).to be(true)
          expect(login_obj.context.user).to eq(user)
          expect(result).to be_instance_of(String)
        end

        it "should fail the context for #call", skip_resource: true do
          allow(login_obj).to receive(:grab_resource).and_raise(StandardError, 'Oops! Something went wrong.')
          expect { login_obj.call }.to raise_error(Interactor::Failure)
          expect(login_obj.context.error).to eql('Oops! Something went wrong.')
        end

        it "should raise error for #authenticate in case of invalid credentials" do
          allow(resource).to receive(:valid_password?).and_return(false)
          expect { login_obj.send(:authenticate!) }.to raise_error('Invalid Credentials')
        end

        it "should fail the context for #authenticate!" do
          context = Interactor::Context.new
          allow(context).to receive(:success?).and_return(false)
          allow(DeviseResources::GenerateToken).to receive(:call).and_return(context)
          expect { login_obj.send(:authenticate!) }.to raise_error(Interactor::Failure)
        end
      end
    end
  end
end