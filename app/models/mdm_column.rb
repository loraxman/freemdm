
class MdmColumn < ActiveRecord::Base
  belongs_to :mdm_data_type
  belongs_to :mdm_object
end





