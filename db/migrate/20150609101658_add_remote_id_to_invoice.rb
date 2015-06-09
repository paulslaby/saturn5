class AddRemoteIdToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :remote_id, :integer, null: false
  end
end
