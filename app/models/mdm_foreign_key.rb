class MdmForeignKey < ActiveRecord::Base
  belongs_to :mdm_column
  belongs_to :mdm_object
end