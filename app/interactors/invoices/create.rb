class Invoices::Create
  include Interactor

  def call
    create_invoice
    send_emails
  end

  private

  def create_invoice
    context.invoice = Invoice.new(context.params) 
    context.fail! unless context.invoice.save 
  end

  def send_emails
    Invoices::SendEmail.call(params: context.invoice)
  end
end