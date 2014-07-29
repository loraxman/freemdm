class MdmModel < ActiveRecord::Base
	has_many :mdm_objects , dependent: :destroy
	
end





