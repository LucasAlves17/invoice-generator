class Invoices::SendEmail
  include Interactor

  def call
    send_emails
  end

  private

  def send_emails
    pdf = create_invoice_pdf
    InvoiceMailer.invoice(context.params, pdf).deliver_now!
  end

  def create_invoice_pdf
    pdf = Prawn::Document.new
    pdf.text "Invoice number: #{context.params.number}"
    pdf.text "Date: #{context.params.date}"
    pdf.text "Company: #{context.params.company}"
    pdf.text "Charge for: #{context.params.charge_for}"
    pdf.text "Total: #{context.params.total_in_cents.to_f / 100}"
    pdf
  end
end