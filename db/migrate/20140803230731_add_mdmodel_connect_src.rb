class AddMdmodelConnectSrc < ActiveRecord::Migration
  def up
    add_column :mdm_models, :connect_src, :string
  end
  def down
    drop_column :mdm_models, :connect_src
  end
end
