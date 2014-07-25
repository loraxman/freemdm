#represents a physical storage unit for a model
#could vary by physical database
class MdmDataContainer < ActiveRecord::Base
  has_many :mdm_models
  belongs_to :database_variant
  #db implementation
    #db variant
    #host
  #name
end