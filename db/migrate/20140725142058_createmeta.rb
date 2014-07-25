class Createmeta < ActiveRecord::Migration
  def up
    create_table :mdm_data_types do |t|
      t.string :name
      t.string :sql_type
     end
    
    create_table :mdm_columns do |t|
      t.string :name
      t.integer :mdm_data_type_id
      t.integer :mdm_object_id
      t.string :precision
      t.string :scale
    end
    
    create_table :mdm_primary_keys do |t|
      t.integer :mdm_column_id
      t.integer :mdm_object_id
    end

    create_table :mdm_foreign_keys do |t|
      t.integer :mdm_column_id
      t.integer :mdm_object_id
    end
    
    create_table :mdm_objects do |t|
      t.string :name
      t.integer :mdm_model_id
    end
    
    create_table :mdm_models do |t|
      t.string :name
    end
  end
  
  def down
    drop_table :mdm_data_types
    drop_table :mdm_columns
    drop_table :mdm_objects
    drop_table :mdm_models
    drop_table :mdm_primary_keys
    drop_table :mdm_foreign_keys  
  end
end
