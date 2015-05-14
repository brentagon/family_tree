class ChangePersonTableName < ActiveRecord::Migration
    def change
        rename_table(:person, :people)
    end
end
