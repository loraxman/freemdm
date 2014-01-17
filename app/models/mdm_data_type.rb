
class MdmDataType < CouchRest::Model::Base
#	include CouchRest::Model::Embeddable
	property :typename, String
	property :precision, Integer
	property :scale, Integer
end





