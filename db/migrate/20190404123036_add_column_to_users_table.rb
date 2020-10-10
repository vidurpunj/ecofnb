class AddColumnToUsersTable < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :name, :string
    add_column :users, :website, :string
    add_column :users, :phone, :string
    add_column :users, :terms_of_service, :boolean
  end
end
