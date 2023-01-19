class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.integer :number, null: false
      t.datetime :date, null: false
      t.string :company, null: false
      t.string :charge_for, null: false
      t.integer :total_in_cents, null: false
      t.string :emails, array: true, default: []

      t.timestamps
    end
  end
end
