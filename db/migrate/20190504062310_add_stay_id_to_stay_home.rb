class AddStayIdToStayHome < ActiveRecord::Migration[5.2]
  def change
    add_column :stay_homes, :stay_id, :integer
    add_column :stays, :slug, :string
  end
end
