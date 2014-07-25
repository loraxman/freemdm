class MdmPrimaryKey < ActiveRecord::Base
  belongs_to :mdm_column
  belongs_to :mdm_object
end