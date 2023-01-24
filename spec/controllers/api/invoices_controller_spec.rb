require "rails_helper"

RSpec.describe Api::InvoicesController, type: :controller do
  let(:user) { create :user }

  describe "#create" do
    context "when successful" do
      let(:valid_params) { attributes_for :invoice }
      let(:invoice) { create :invoice }
      let(:controller_params) { ActionController::Parameters.new(invoice: valid_params) }

      before do
        expect(Invoices::Create).to receive(:call).once.with(params: 
                                                              controller_params
                                                              .require(:invoice)
                                                              .permit(:number, :date, :company, :charge_for, :total_in_cents, emails: []))
                                                              .and_return(context)
      end

      let(:context) { double(:context, success?: true, invoice: invoice) }

      it "return 201" do
        request.headers["Authorization"] = user[:token]
        request.headers["Content-Type"] = 'application/json'
 
        response = post :create, params: { invoice: valid_params }

        expect(response.status).to eq(201)
      end
    end

    context "when unsuccessful" do
      let(:invalid_params) { attributes_for :invalid_invoice }
      let(:controller_params) { ActionController::Parameters.new(invoice: invalid_params) }

      before do
        expect(Invoices::Create).to receive(:call).once.with(params: 
                                                              controller_params
                                                              .require(:invoice)
                                                              .permit(:number, :date, :company, :charge_for, :total_in_cents, emails: []))
                                                              .and_return(context)
      end

      let(:context) { double(:context, success?: false, invoice: nil, errors: { "number": ["can't be blank"] }) }

      it "return 422" do
        request.headers["Authorization"] = user[:token]
        request.headers["Content-Type"] = 'application/json'
 
        response = post :create, params: { invoice: invalid_params }

        expect(response.status).to eq(422)
      end
    end
  end

  describe "#update" do
    let(:invoice) { create :invoice }

    context "when successful" do
      let(:valid_params) do
        { emails: [Faker::Internet.email, Faker::Internet.email] }
      end
      let(:controller_params) { ActionController::Parameters.new(invoice: valid_params) }

      before do
        expect(Invoices::UpdateEmailList).to receive(:call).once.with(params: 
                                                              controller_params
                                                              .require(:invoice)
                                                              .permit(emails: [])
                                                              .merge(id: invoice.id.to_s))
                                                              .and_return(context)
      end

      let(:context) { double(:context, success?: true, invoice: invoice) }

      it "return 200" do
        request.headers["Authorization"] = user[:token]
        request.headers["Content-Type"] = 'application/json'

        response = patch :update, params: { id: invoice.id, invoice: valid_params }

        expect(response.status).to eq(200)
      end
    end

    context "when unsuccessful" do
      let(:invalid_params) do
        { emails: [] }
      end
      let(:controller_params) { ActionController::Parameters.new(invoice: invalid_params) }

      before do
        expect(Invoices::UpdateEmailList).to receive(:call).once.with(params: 
                                                              controller_params
                                                              .require(:invoice)
                                                              .permit(emails: [])
                                                              .merge(id: invoice.id.to_s))
                                                              .and_return(context)
      end

      let(:context) { double(:context, success?: false, invoice: nil, errors: { "number": ["can't be blank"] }) }

      it "return 422" do
        request.headers["Authorization"] = user[:token]
        request.headers["Content-Type"] = 'application/json'

        response = patch :update, params: { id: invoice.id, invoice: invalid_params }

        expect(response.status).to eq(422)
      end
    end
  end
end