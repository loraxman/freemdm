
class MdmObject < ActiveRecord::Base
  has_many :mdm_primary_keys,dependent: :destroy
  has_many :mdm_foreign_keys,dependent: :destroy
	has_many :mdm_columns, through: :mdm_primary_keys
	has_many :mdm_columns, through: :mdm_foreign_keys
	has_many :mdm_columns, dependent: :destroy
	belongs_to :mdm_model
	
	after_save :generate_angular_ctl
	
	def generate_angular_ctl
	  ang_gen = AngularGenerator.new(self)
	  ang_gen.generate_angular
	end
end




