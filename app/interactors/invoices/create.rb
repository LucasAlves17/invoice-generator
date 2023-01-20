class Invoices::Create
  include Interactor

  def call
    send_emails if create_invoice
  end

  private

  def create_invoice
    context.invoice = Invoice.new(context.params) 
    context.fail! unless context.invoice.save 
  end

  def send_emails
    context.invoice.emails.each do |email|
      #Invoices::SendByEmail.call(email)
    end
  end
end