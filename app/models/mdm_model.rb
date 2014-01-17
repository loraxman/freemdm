class MdmModel < CouchRest::Model::Base
	include CouchRest::Model::Embeddable
	property :mdmobjects, [MdmObject]
end





