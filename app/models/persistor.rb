class Persistor

 
  #ddl or metadata to db where required
  def promote(model)
  end
	
	#grab schemas here and build the group of MDMObjects 
	# per table
	#NOTE: Do we assume a new model?
  def retrieve_database_meta(modelname, adapter,driver,host,username,password,database,urltemplate)
  
    urltemplate.gsub!("{host}",host)
    urltemplate.gsub!("{password}",password)
    urltemplate.gsub!("{username}",username)
    urltemplate.gsub!("{database}",database)
    mdmtype=MdmDataType.first
  
    curr_connect = ActiveRecord::Base.connection
    if adapter=="mysql"
      arconfig = {
      :adapter  => adapter,
      :host     => host,
      :username => username,
      :password => password,
      :database => database }
  
      config = ActiveRecord::ConnectionAdapters::ConnectionSpecification.new( {
              :adapter => adapter,
              :driver => driver,
              :username => username,
              :password => password,
              :host  => host,
              :url => urltemplate,
                :pool => 2
              }, 'mysql_connection')
  
      connection = ActiveRecord::ConnectionAdapters::ConnectionPool.new(config)
  
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
              
      connection = ActiveRecord::ConnectionAdapters::ConnectionPool.new(config)
    end
    
    primary_k = {}
    newtables={}
    metaconnect = connection.checkout
     metaconnect.tables.each do |table|
      newtables[table] = [] 
      primary_k[table] = metaconnect.primary_key(table)
       metaconnect.columns(table.to_s).each do |col|
          newtables[table] << col.name
          print col.name + ", "
      end
    end
    
    connection.checkin metaconnect
  
   
    mdm_model = MdmModel.find_by_name(modelname) 
    mdm_model = MdmModel.new if mdm_model.nil? 
    mdm_model.connect_src = serialize_config(adapter,driver,host,username,password,database,urltemplate)
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
        mdmcolumn.is_primary_key=true if !primary_k[table].nil? && primary_k[table].include?(mdmcolumn.name)
        mdmcolumn.save
        if mdmcolumn.is_primary_key
            pk = MdmPrimaryKey.new
            pk.mdm_column = mdmcolumn
            mdmobject.mdm_primary_keys << pk
        end
        mdmobject.mdm_columns << mdmcolumn
      end
      mdm_model.mdm_objects << mdmobject
  
    end
  
    mdm_model.save
    generate_active_record(mdm_model,arconfig)
  end
	
	
  def serialize_config(adapter,driver,host,username,password,database,urltemplate)
    config_hash = {:adapter=>adapter,:driver=>driver,:host=>host,:username=>username,:password=>password,:database=>database,
    :url=>urltemplate}
    config_hash.to_json
  end
	#serialize an mdm_object 
	#could be that the class is generated at runtime like AR and this is an 
	#AR instnce or it is a hash/json.
	
	
  
	
	
  def generate_active_record(mdm_model, config)
    #do the code to create new classes based on model metadata
    #and load them up in the Ruby VM
    #below NOTE! Need table created first for AR
     #AR provides a #column_names method that returns an array of column names
    
    mdm_model.mdm_objects.each do |mdm_object|
       klass = Class.new ActiveRecord::Base do
         #establish_connection(config)
         #AR to set the physical tablename
         before_save :diff_row
         self.table_name = mdm_object.name
        
         #below does composite keys!
         
         if mdm_object.mdm_primary_keys.size > 0
            pkeys = mdm_object.mdm_primary_keys.collect{|x| x.mdm_column.name.to_sym }
            self.primary_keys = pkeys
            @@pklist = pkeys
            puts "-" * 80
            puts mdm_object.name, pkeys.size
         end
         #note this is FK implementation
         #  has_many :statuses, :class_name => 'MembershipStatus', :foreign_key => [:user_id, :group_id]

         def name
           
         end
         
         def diff_row
           #here we send changes out over to the queue
           #we need PK followed by row
           puts self.changes
           pkvals = {}
           changevals = {}
           self.class.primary_keys.each do |k|
             pkvals[k] = self.read_attribute(k)
           end
           changevals['colvals'] = self.changes
           changevals['pkeys'] = pkvals
           redis = Redis.new
           redis.publish("mdm:freemdm", changevals.to_json)
         end
       end
     
   
       #NOTE will need some adjustments to fit legacy tables to AR
      Object.const_set mdm_object.name.capitalize, klass
      puts config.symbolize_keys
      klass.establish_connection(config.symbolize_keys)
    #  eval("class #{klass.name}; attr_accessible *columns;end")
    #

    end
  
  end
end
