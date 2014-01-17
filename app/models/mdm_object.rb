
class MdmObject < CouchRest::Model::Base
	include CouchRest::Model::Embeddable
	property :name, String
	property :columns, [MdmColumn]
	property :primary_keys, [MdmColumn]
	property :foreign_keys, [MdmColumn]
end




