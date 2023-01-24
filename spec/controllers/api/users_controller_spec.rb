require "rails_helper"

RSpec.describe Api::UsersController, type: :controller do
  describe "#create" do
    context "when successful" do
      let(:email) { Faker::Internet.email }
      before do
        expect(Users::GenerateToken).to receive(:call).once.with(email: email).and_return(context)
      end

      let(:context) { double(:context, success?: true ) }

      it "return 201" do
        response = post :create, params: { email: email }

        expect(response.status).to eq(201)
      end
    end

    context "when unsuccessful" do
      before do
        expect(Users::GenerateToken).to receive(:call).once.with(email: "").and_return(context)
      end

      let(:context) { double(:context, success?: false, errors: "Email is missing") }

      it "return 422" do
        response = post :create, params: { email: "" }

        expect(response.status).to eq(422)
      end
    end
  end

  describe "#confirm" do
    context "when successful" do
      let(:user_to_confirm) { create :user_to_confirm }

      before do
        expect(Users::ConfirmToken).to receive(:call).once.with(token_to_confirm: user_to_confirm[:token_to_confirm]).and_return(context)
      end

      let(:context) { double(:context, success?: true ) }

      it "return 200" do
        response = get :confirm, params: { token: user_to_confirm[:token_to_confirm] }

        expect(response.status).to eq(200)
      end
    end

    context "when unsuccessful" do
      before do
        expect(Users::ConfirmToken).to receive(:call).once.with(token_to_confirm: "123").and_return(context)
      end

      let(:context) { double(:context, success?: false, errors: "Invalid token") }

      it "return 422" do
        response = get :confirm, params: { token: "123" }

        expect(response.status).to eq(422)
      end
    end
  end
end