class Invoices::UpdateEmailList
  include Interactor

  def call
    find_invoice
    send_emails
    update_email_list
  end

  private

  def find_invoice
    context.invoice = Invoice.find(context.params[:id])
  end

  def send_emails
    Invoices::SendEmail.call(params: email_params)
  end

  def update_email_list
    context.params[:emails].each do |new_email|
      context.invoice.emails << new_email
    end
    context.invoice.save
  end

  def email_params
    context.invoice.slice(:number, :date, :company, :charge_for, :total_in_cents).merge(emails: context.params[:emails])    
  end
end