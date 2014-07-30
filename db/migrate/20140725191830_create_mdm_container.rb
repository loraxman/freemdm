class CreateMdmContainer < ActiveRecord::Migration
  def up
    create_table :mdm_data_containers do |t|
      t.string  :name
    end
    add_column :mdm_models, :mdm_data_container_id, :integer
    create_table :database_variants do |t|
      t.string :name
      t.string :connect_info
    end
  end
  
  def down
    drop_table :mdm_data_containers
    remove_column :mdm_models, :mdm_data_container_id
  end
end
