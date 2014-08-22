class Api::MdmColumnsController < ApplicationController
  skip_before_filter  :verify_authenticity_token 
  def show
    @mdm_column = MdmColumn.find(params[:id])
    render :json => @mdm_column.to_json(:include => :mdm_data_type)
  end
  
  def index
    @mdm_columns = MdmColumn.all
    render :json => @mdm_columns.to_json()
  end
  
  def update
    puts "*" * 80
    puts params.inspect
    mdm_column = MdmColumn.find(params[:id])
    mdm_column.name = params[:name]
    mdm_data_type = MdmDataType.find(params[:mdm_data_type_id])
    mdm_column.mdm_data_type = mdm_data_type
    mdm_column.precision = params[:precision]
    mdm_column.scale = params[:scale]
    mdm_column.save!
    puts mdm_column.inspect
    
    render :json => {"status" => "ok"}
   
  end

end