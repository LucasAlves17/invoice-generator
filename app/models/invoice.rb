class Invoice < ApplicationRecord
  include Filterable

  validates_presence_of :number, :date, :company, :charge_for, :total_in_cents, :emails

  scope :filter_by_number, -> (number) { where number: number }
  scope :filter_by_date, -> (date) { where date: date }
end
