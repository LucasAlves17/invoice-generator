class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :number, :date, :company, :charge_for, :total_in_cents, :emails
end
