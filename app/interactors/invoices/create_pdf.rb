class Invoices::CreatePdf
  include Interactor

  def call
    pdf = Prawn::Document.new
    pdf.text "Invoice number: #{context.params[:number]}"
    pdf.text "Date: #{context.params[:date]}"
    pdf.text "Company: #{context.params[:company]}"
    pdf.text "Charge for: #{context.params[:charge_for]}"
    pdf.text "Total: #{context.params[:total_in_cents].to_f / 100}"
    context.pdf = pdf
  end
end