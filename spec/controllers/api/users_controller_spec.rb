require "rails_helper"

RSpec.describe Api::UsersController, type: :controller do
  describe "#create" do
    context "when successful" do
      let(:email) { Faker::Internet.email }
      before do
        expect(User::GenerateToken).to receive(:call).once.with(email: email).and_return(context)
      end

      let(:context) { double(:context, success?: true, message: "A confirmation email has been sent to your email address. Please check your inbox to activate your account.") }

      it "show a message that an email was send" do
        response = post :create, params: { email: email }

        expect(response.parsed_body["message"]).to eq(context.message)
      end
    end

    context "when unsuccessful" do
      before do
        expect(User::GenerateToken).to receive(:call).once.with(email: "").and_return(context)
      end

      let(:context) { double(:context, success?: false, errors: "Email is missing") }

      it "show a error message" do
        response = post :create, params: { email: "" }

        expect(response.parsed_body["errors"]).to eq(context.errors)
      end
    end
  end
end