
class MdmObject < ActiveRecord::Base
  has_many :mdm_primary_keys
  has_many :mdm_foriegn_keys
	has_many :mdm_columns, through: :mdm_primary_keys
	has_many :mdm_columns, through: :mdm_foreign_keys
	has_many :mdm_columns
	belongs_to :mdm_model
end




