class CreateFaqTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :faq_types do |t|

      t.timestamps
    end
  end
end
