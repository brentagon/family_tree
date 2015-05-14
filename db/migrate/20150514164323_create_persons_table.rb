class CreatePersonsTable < ActiveRecord::Migration
  def change
      create_table :person do |t|
          t.string :name
      end
  end
end
