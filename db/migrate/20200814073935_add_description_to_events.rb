class AddDescriptionToEvents < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :description, :text
    add_index :events, :description, :unique => true
  end
  
end
