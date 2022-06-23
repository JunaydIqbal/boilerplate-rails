require 'rails_helper'

RSpec.shared_examples 'AuthenticableUser' do
  let(:user) { create(:user) }
  let(:secret_key) { app.secret_key_base }
  let(:decoded_token) { [{"data"=>"test"}, {"alg"=>"none"}] }

  context "Methods" do
    describe "Private" do
      before do |example|
        unless example.metadata[:skip_request]
          post "/graphql"
          request.headers["Authorization"] = "Basic eyJhbGciOiJub25lIn0.eyJkYXRhIjoidGVzdCJ9"
          subject.instance_variable_set(:@_request, request)
        end
      end

      it "should check #current_user", skip_request: true do
        allow(subject).to receive(:grab_auth_resource_by).with(User).and_return(user)
        subject.send(:current_user)
        expect(subject.instance_variable_get(:@current_user)).to eq(user)
      end

      it "should check #token" do
        subject.send(:token)

        expect(subject.instance_variable_get(:@token)).to eql("eyJhbGciOiJub25lIn0.eyJkYXRhIjoidGVzdCJ9")
      end

      it "should check #decoded_token" do
        subject.send(:decoded_token)

        expect(subject.instance_variable_get(:@decoded_token)).to eql(decoded_token)
      end

      it "should rescue JWT::DecodeError for #decoded_token", skip_request: true do
        allow(subject).to receive(:decoded_token).and_raise(JWT::DecodeError)
        expect{ subject.send(:decoded_token) }.to raise_error(JWT::DecodeError)
      end

      it "should check #payload_data" do
        subject.send(:payload_data)
        
        expect(subject.instance_variable_get(:@payload_data)).to eq(decoded_token.reduce({}, :merge))
      end

      it "should check #secret_key", skip_request: true do
        expect(subject.send(:secret_key)).to eql(secret_key)  
      end

      it "should check #grab_auth_resource_by(klass)" do
        dt = decoded_token.reduce({}, :merge)
        dt.merge!({ "sub" => user.id })
        subject.instance_variable_set(:@payload_data, dt)

        expect(subject.send(:grab_auth_resource_by, User)).to eq(user)
      end
    end
  end
end
