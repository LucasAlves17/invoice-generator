require "rails_helper"

RSpec.describe Invoices::SendEmail do
  describe ".call" do
    let(:invoice_params) { attributes_for :invoice }
    subject(:context) { Invoices::SendEmail.call(params: invoice_params) }
    let(:pdf) { double(:pdf) }
    let(:result) { double(:result, pdf: pdf) }

    before do
      allow(Invoices::CreatePdf).to receive(:call).with(params: invoice_params).and_return(result)
      allow_any_instance_of(InvoiceMailer).to receive(:invoice).with(invoice_params, pdf)
    end

    it "succeeds" do
      expect(context).to be_a_success
    end
  end
end