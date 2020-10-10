class CreateEmailTemplates < ActiveRecord::Migration[5.2]
  def change
    create_table :email_templates do |t|
      t.text :user_admincheckout_email
      t.timestamps
    end
  end
end
