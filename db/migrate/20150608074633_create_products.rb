class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
     t.integer :user_id
	   t.string :content
	   t.integer :category1
     t.string :title
	   t.string :link
	   t.boolean :available, :default => false
     t.string :company_name
     t.integer :status
     t.timestamps
    end
  end
end
