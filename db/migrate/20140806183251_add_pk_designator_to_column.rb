class AddPkDesignatorToColumn < ActiveRecord::Migration
  def up
    add_column :mdm_columns, :is_primary_key, :boolean
  end
  
  def down
    remove_column :mdm_columns, :is_primary_key
  end
end
