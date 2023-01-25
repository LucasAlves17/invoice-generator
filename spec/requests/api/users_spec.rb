require 'rails_helper'

RSpec.describe "/api/users", type: :request do

  describe "POST /users" do
    context "with valid parameters" do
      context "with an email that isn't registered" do
        let(:user) { attributes_for :user }
        
        it "creates a new User" do
          expect {
            post api_users_url,
                 params: { email: user[:email] }, as: :json
          }.to change(User, :count).by(1)
        end
  
        it "renders a JSON response with the new user" do
          post api_users_url, params: { email: user[:email] }, as: :json
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end

      context "with an email that is already registered" do
        let(:user_created) { create :user }

        it "does not create a new User" do
          post api_users_url, params: { email: user_created[:email] }, as: :json
          user_count = User.where(email: user_created[:email]).count
          expect(user_count).to eq(1)
        end
  
        it "generate a token_to_confirm" do
          post api_users_url, params: { email: user_created[:email] }, as: :json
          user_created.reload

          expect(response).to have_http_status(:created)
          expect(user_created[:token_to_confirm]).not_to eq(nil)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post api_users_url,
               params: { email: nil }, as: :json
        }.to change(User, :count).by(0)
      end

      it "renders a JSON response with errors for the new user" do
        post api_users_url,
             params: { email: nil }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "GET /users/confirm" do
    let(:user_to_confirm) { create :user_to_confirm }

    it "renders a successful response" do
      get api_confirm_users_url, params: { token: user_to_confirm[:token_to_confirm] }
      expect(response).to be_successful
    end
  end

  describe "POST /users/login" do
    let(:user) { create :user }

    context "with valid parameters" do
      it "renders a successful response" do
        post api_login_users_url, params: { token: user[:token] }, as: :json
        expect(response).to be_successful
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors" do
        post api_login_users_url, params: { token: "123" }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
