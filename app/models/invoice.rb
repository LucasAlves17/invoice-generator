class Invoice < ApplicationRecord
  validates_presence_of :number, :date, :company, :charge_for, :total_in_cents, :emails
end
