class CreateFamilyTable < ActiveRecord::Migration
  def change
      create_table :families do |t|
          t.integer :child_id
          t.integer :parent_id
          t.timestamps null:false
      end         
  end
end
