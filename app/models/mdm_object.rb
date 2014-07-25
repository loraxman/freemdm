
class MdmObject < ActiveRecord::Base
	has_many :mdm_columns, through: :mdm_primary_keys
	has_many :mdm_columns, through: :mdm_foreign_keys
	has_many :foreign_keys
	belongs_to :mdm_model
end




