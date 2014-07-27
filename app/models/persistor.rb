class Persistor

	#ddl or metadata to db where required
	def promote(model)
	end
	
	#serialize an mdm_object 
	#could be that the class is generated at runtime like AR and this is an 
	#AR instnce or it is a hash/json
	
	#below NOTE! Need table created first for AR
  klass = Class.new ActiveRecord::Base do
    def name
      "#{super} Doe"
    end
  end
  
  module Company
  end
  
  Company.const_set "Employee", klass
  
  puts Company::Employee.new.name # prints "Jon Doe"
  
 
  
	def serialize(row)
	end
end
