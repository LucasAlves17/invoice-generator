class Api::InvoicesController < ApplicationController

  # GET /invoices
  def index
    @invoices = Invoice.all

    render json: @invoices
  end

  # GET /invoices/1
  def show
    Invoice.find(params[:id])

    render json: @invoice
  end

  # POST /invoices
  def create
    result = Invoices::Create.call(params: invoice_params)
    @invoice = result.invoice

    if result.success?
      render json: @invoice, location: api_invoice_url(@invoice)
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /invoices/1
  def update
    result = Invoices::UpdateEmailList.call(params: invoice_new_emails)
    @invoice = result.invoice

    if result.success?
      render json: @invoice, location: api_invoice_url(@invoice)
    else
      render json: @invoice.errors, status: :unprocessable_entity
    end
  end

  private

  def invoice_params
    params.require(:invoice).permit(:number, :date, :company, :charge_for, :total_in_cents, emails: [])
  end

  def invoice_new_emails
    params.require(:invoice).permit(emails: []).merge(id: params[:id])
  end
end
