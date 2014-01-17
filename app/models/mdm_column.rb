
class MdmColumn < CouchRest::Model::Base
	include CouchRest::Model::Embeddable
	property :name, String
	property :datatype, MdmDataType
end





