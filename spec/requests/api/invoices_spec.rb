require 'rails_helper'

RSpec.describe "/api/invoices", type: :request do
  let(:user) { create :user }
  let(:valid_attributes) { attributes_for :invoice }
  let(:invalid_attributes) { attributes_for :invalid_invoice }
  let(:valid_headers) do
    { Authorization: user[:token] }
  end

  describe "GET /index" do
    it "renders a successful response" do
      Invoice.create! valid_attributes
      get api_invoices_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      invoice = Invoice.create! valid_attributes
      get "#{api_invoices_url}/#{invoice[:id]})", as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Invoice" do
        expect {
          post api_invoices_url,
               params: { invoice: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Invoice, :count).by(1)
      end

      it "renders a JSON response with the new invoice" do
        post api_invoices_url,
             params: { invoice: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Invoice" do
        expect {
          post api_invoices_url,
               params: { invoice: invalid_attributes }, as: :json
        }.to change(Invoice, :count).by(0)
      end

      it "renders a JSON response with errors for the new invoice" do
        post api_invoices_url,
             params: { invoice: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PUT /update" do
    context "with valid parameters" do
      let(:new_email) { Faker::Internet.email }
      let(:new_attributes) {
        { emails: [new_email] }
      }

      it "updates the requested invoice" do
        invoice = Invoice.create! valid_attributes
        put "#{api_invoices_url}/#{invoice[:id]})", params: { invoice: new_attributes }, headers: valid_headers, as: :json
        invoice.reload
        expect(invoice.emails).to include(new_email)
      end

      it "renders a JSON response with the invoice" do
        invoice = Invoice.create! valid_attributes
        put "#{api_invoices_url}/#{invoice[:id]})",
              params: { invoice: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the invoice" do
        invoice = Invoice.create! valid_attributes
        put "#{api_invoices_url}/#{invoice[:id]})",
              params: { invoice: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
