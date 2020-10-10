class AddColoumFaq < ActiveRecord::Migration[5.2]
  def change
  	 add_column :faqs, :faq_type_id, :integer
  end
end
