class Persistor

	#ddl or metadata to db where required
	def promote(model)
	end
	
	#grab schemas here and build the group of MDMObjects 
	# per table
	def retrieve_database_meta(adapter,host,username,password,database)
    connection = ActiveRecord::Base.establish_connection(
         :adapter  => adapter,
         :host     => host,
         :username => username,
         :password => password,
         :database => database
       )
    metaconnect = connection.connection
    t = "mdm_objects"
    puts metaconnect
    puts metaconnect.columns(t)[1].name
    metaconnect.tables.each do |table|
      puts table
      begin
      metaconnect.columns(table.to_s).each do |col|
        print col.name + ", "
      end
      puts
      rescue 
        puts 'err'
      end
    end
	end
	
	#serialize an mdm_object 
	#could be that the class is generated at runtime like AR and this is an 
	#AR instnce or it is a hash/json
	
	def temp

  	#below NOTE! Need table created first for AR
    #AR provides a #column_names method that returns an array of column names
    klass = Class.new ActiveRecord::Base do
      establish_connection(
          :adapter  => "mysql",
          :host     => "localhost",
          :username => "myuser",
          :password => "mypass",
          :database => "somedatabase"
        )
    
      def name
        "#{super} Doe"
      end
    end
    
    module Company
    end
    
    Company.const_set "Employee", klass
    
    puts Company::Employee.new.name # prints "Jon Doe"
    
    
    #below example of how to connect at runtime for Active Record.
    ActiveRecord::Base.establish_connection(
      :adapter  => "mysql",
      :host     => "localhost",
      :username => "myuser",
      :password => "mypass",
      :database => "somedatabase"
    )
    
    # model in the "default" database from database.yml
    class Person < ActiveRecord::Base
    
      # ... your stuff here
    
    end
    
    # model in a different database
    class Place < ActiveRecord::Base
    
      establish_connection(
          :adapter  => "mysql",
          :host     => "localhost",
          :username => "myuser",
          :password => "mypass",
          :database => "somedatabase"
        )
    
    end
	end
  
	def serialize(row)
	end
end
