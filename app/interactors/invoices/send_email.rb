class Invoices::SendEmail
  include Interactor

  def call
    result = Invoices::CreatePdf.call(params: context.params)
    InvoiceMailer.invoice(context.params, result.pdf).deliver_now!
  end
  
end