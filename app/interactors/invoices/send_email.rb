class Invoices::SendEmail
  include Interactor

  def call
    pdf = Invoices::CreatePdf.call(params: context.params)
    InvoiceMailer.invoice(context.params, pdf).deliver_now!
  end
  
end