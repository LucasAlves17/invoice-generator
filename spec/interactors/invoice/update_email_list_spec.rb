require "rails_helper"

RSpec.describe Invoices::UpdateEmailList do
  let(:invoice) { create :invoice }
  let(:invoice_params) { attributes_for :invoice }

  describe ".call" do
    context "when given valid email" do
      let(:invoice_new_emails) do
         { id: invoice[:id], emails: [Faker::Internet.email] }
      end
      subject(:context) { Invoices::UpdateEmailList.call(params: invoice_new_emails) }

      before do
        allow(invoice_new_emails[:emails]).to receive(:count).and_return(1)
        allow(Invoice).to receive(:find).with(invoice_new_emails[:id]).and_return(invoice)
        send_email_params = invoice.slice(:number, :date, :company, :charge_for, :total_in_cents)
                                    .merge(emails: invoice_new_emails[:emails])
        allow(Invoices::SendEmail).to receive(:call).with(params: send_email_params)
        allow(invoice).to receive(:save).and_return(invoice)
      end

      it "succeeds" do
        expect(context).to be_a_success
      end
    end

    context "when given invalid email" do
      let(:invoice_params) do
        { id: invoice[:id], emails: [] }
      end
      subject(:context) { Invoices::UpdateEmailList.call(params: invoice_params) }

      before do
        allow(invoice_params[:emails]).to receive(:count).and_return(0)
      end

      it "fails" do
        expect(context).to be_a_failure
      end
    end
  end
end