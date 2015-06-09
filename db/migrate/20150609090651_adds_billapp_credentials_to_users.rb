class AddsBillappCredentialsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :billapp_login, :string
    add_column :users, :billapp_password, :string
    add_column :users, :billapp_agenda, :string
  end
end
