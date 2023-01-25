class InvoiceMailer < ApplicationMailer
  def invoice(invoice, invoice_file)
    attachments['invoice.pdf'] = { mime_type: 'application/pdf', content: invoice_file.render() }
    @emails = invoice[:emails]
    @link = "http://localhost:3001/#invoices/#{invoice[:id]}"
    mail to: @emails, subject: 'Invoice'
  end
end
