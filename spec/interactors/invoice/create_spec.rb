require "rails_helper"

RSpec.describe Invoices::Create do
  describe ".call" do
    context "when given valid params" do
      let(:invoice) { double(:invoice) }
      let(:invoice_params) { attributes_for :invoice }
      subject(:context) { Invoices::Create.call(params: invoice_params) }
      
      before do
        allow(Invoice).to receive(:new).with(invoice_params).and_return(invoice)
        allow(invoice).to receive(:save).and_return(invoice)
        allow(Invoices::SendEmail).to receive(:call).with(params: invoice)
      end

      it "succeeds" do
        expect(context).to be_a_success
      end

      it "provides the invoice" do
        expect(context.invoice).to eq(invoice)
      end
    end

    context "when given invalid params" do
      let(:invoice) { double(:invoice, errors: {"number": ["can't be blank"] }) }
      let(:invalid_invoice_params) { attributes_for :invalid_invoice }
      subject(:context) { Invoices::Create.call(params: invalid_invoice_params) }

      before do
        allow(Invoice).to receive(:new).with(invalid_invoice_params).and_return(invoice)
        allow(invoice).to receive(:save).and_return(false)
      end

      it "fails" do
        expect(context).to be_a_failure
      end
    end
  end
end