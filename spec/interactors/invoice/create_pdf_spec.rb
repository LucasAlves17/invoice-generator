require "rails_helper"

RSpec.describe Invoices::CreatePdf do
  describe ".call" do
    let(:invoice_params) { attributes_for :invoice }
    subject(:context) { Invoices::CreatePdf.call(params: invoice_params) }
    let(:pdf) { double(:pdf, text: "Invoice number: xxx...") }

    before do
      allow(Prawn::Document).to receive(:new).and_return(pdf)
    end

    it "succeeds" do
      expect(context).to be_a_success
    end

    it "provides the pdf" do
      expect(context.pdf).to eq(pdf)
    end
  end
end