Rails.application.config.after_initialize do
  # initialization code goes here

  
      # initialization code goes here
      p = Persistor.new
      #get all the models and their connects
      
      models = MdmModel.all
      
      models.each do | model|
        begin
          if model.connect_src
            config = JSON.parse(model.connect_src)
            puts config.inspect
            puts "*" * 80
            p.generate_active_record(model, config)
          end
        rescue
          puts "db issue"
        end
      end
end
