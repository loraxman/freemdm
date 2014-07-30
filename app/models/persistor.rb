class Persistor

  class JDBCAR < ActiveRecord::Base
    def connect(driver, username,password, urltemplate)
   
      connection = ActiveRecord::Base.establish_connection(
        :adapter => 'jdbc',
        :driver => driver,
        :username => username,
        :password => password,
      
        :url => urltemplate)
      return connection

    end
  end
  
	#ddl or metadata to db where required
	def promote(model)
	end
	
	#grab schemas here and build the group of MDMObjects 
	# per table
	#NOTE: Do we assume a new model?
	def retrieve_database_meta(modelname, adapter,driver,host,username,password,database,urltemplate)
=begin	  
    :adapter => 'jdbc',
      :driver => 'oracle.jdbc.OracleDriver',
      :url => jdbc:oracle:thin:#{userid}/#{password}@#{host_name}:1521:#{db_name}"
    )
    
    "jdbc:mysql://{host}/{database}?" +
                                       "user={username}&password={password}"
     jdbc:mysql://localhost/HerongDB?user=Herong&password=TopSecret
    jdbc:mysql://localhost/freemdm?user=root&password=password
    urlfull = urltemplate
=end   
    urltemplate.gsub!("{host}",host)
    urltemplate.gsub!("{password}",password)
    urltemplate.gsub!("{username}",username)
    urltemplate.gsub!("{database}",database)
    mdmtype=MdmDataType.first

    puts urltemplate
    curr_connect = ActiveRecord::Base.connection
    if adapter=="mysql"
      arconfig = {
      :adapter  => adapter,
      :host     => host,
      :username => username,
      :password => password,
      :database => database }

      connection = ActiveRecord::Base.establish_connection(
           :adapter  => adapter,
           :host     => host,
           :username => username,
           :password => password,
           :database => database
         )
    else
    #  jdbc = JDBCAR.new
    #  connection = jdbc.connect(driver,username,password,urltemplate)
      arconfig = {:adapter => 'jdbc',
        :driver => driver,
        :username => username,
        :password => password,
        :url => urltemplate,
      :pool => 2}
      config = ActiveRecord::ConnectionAdapters::ConnectionSpecification.new( {
              :adapter => 'jdbc',
              :driver => driver,
              :username => username,
              :password => password,
            
              :url => urltemplate,
                :pool => 2
              }, 'jdbc_connection')
            puts "===================="
              
      connection = ActiveRecord::ConnectionAdapters::ConnectionPool.new(config)
    end
    
	  newtables={}
	    puts "past here"
    metaconnect = connection.checkout
    puts "DONE!"
    metaconnect.tables.each do |table|
      newtables[table] = [] 
      
      metaconnect.columns(table.to_s).each do |col|
          newtables[table] << col.name
          print col.name + ", "
      end
    end
    
    puts "*" * 80
    connection.checkin metaconnect
  
#    connection = ActiveRecord::Base.establish_connection :development
    print connection
   
    mdm_model = MdmModel.new
    puts "newmodel"
    mdm_model.name = modelname
    newtables.keys.each do |table|
      mdmexist = MdmObject.find_by_name(table)
      mdmexist.destroy if mdmexist
      mdmobject = MdmObject.new
      mdmobject.name=table
      newtables[table].each do |col|
        mdmcolumn = MdmColumn.new
        mdmcolumn.name = col
        mdmcolumn.mdm_data_type = mdmtype
        mdmcolumn.save
        mdmobject.mdm_columns << mdmcolumn
      end
      mdm_model.mdm_objects << mdmobject

    end

    mdm_model.save
    generate_active_record(mdm_model,arconfig)
	end
	
	
	def test
	end
	#serialize an mdm_object 
	#could be that the class is generated at runtime like AR and this is an 
	#AR instnce or it is a hash/json
	
	
  
	def serialize(row)
	end
	
  def generate_active_record(mdm_model, config)
    #do the code to create new classes based on model metadata
    #and load them up in the Ruby VM
    #below NOTE! Need table created first for AR
     #AR provides a #column_names method that returns an array of column names
    
    mdm_model.mdm_objects.each do |mdm_object|
       klass = Class.new ActiveRecord::Base do
         #establish_connection(config)
         
         #AR to set the physical tablename
         self.table_name = mdm_object.name
         
         #below does composite keys!
        #self.primary_keys = :user_id, :group_id
         #note this is FK implementation
         #  has_many :statuses, :class_name => 'MembershipStatus', :foreign_key => [:user_id, :group_id]

         def name
           
         end
       end
     
   
       #NOTE will need some adjustments to fit legacy tables to AR
      puts mdm_object.name.capitalize
      Object.const_set mdm_object.name.capitalize, klass
     
      klass.establish_connection(config)
    end
  
  end
end
