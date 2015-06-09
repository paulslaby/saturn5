class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :number
      t.date :due_date
      t.date :issue_date
      t.date :paid_on
      t.text :notes
      t.string :status
      t.decimal :tax_amount
      t.decimal :total_amount
      t.datetime :created_date
      t.datetime :updated_date
      t.string :currency_code
      t.string :currency_name

      t.timestamps null: false
    end
  end
end
