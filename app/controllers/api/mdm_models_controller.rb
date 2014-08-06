class Api::MdmModelsController < ApplicationController
  skip_before_filter  :verify_authenticity_token 
  def show
    @mdm_model = MdmModel.find(params[:id])
    render :json => @mdm_model.to_json(:include => {:mdm_objects => {:include => :mdm_columns}})
  end
  
  def index
    @mdm_models = MdmModel.all
    render :json => @mdm_models.to_json(:include => {:mdm_objects => {:include => :mdm_columns}})
  end
  
  def save
    #we need a AR name
    klass = eval(params[:ar_name].capitalize)
    pkcols = MdmObject.find_by_name(params[:ar_name]).mdm_columns.select{|x| x.is_primary_key}
  #  allcols = MdmObject.find_by_name(params[:ar_name]).mdm_columns.collect { |u| u.name.to_sym }
  #    puts allcols
  #  klass.attr_accessible allcols
    newparams = {}
    newparams[params[:ar_name].to_sym] = params
    params = newparams
    puts "++++++++++++++"
    pkcols = pkcols.collect { |u| u.name }
      puts pkcols
    pkeys = params.select{|k,v| pkcols.include?(k)}
      puts pkeys.values
    @item = klass.find(pkeys.values)
    puts @item.inspect
    #remove pks from params now
    pkeys.keys.each do |k|
      params.delete(k)
    end
    params.delete("created_at")
    params.delete("updated_at")
    puts "*" * 80
    puts params[params[:ar_name].to_sym]
    
    params.require(params[:ar_name].to_sym).permit(params[params[:ar_name].to_sym].keys())
    @item.update_attributes!(params[params[:ar_name].to_sym])
      puts @item.inspect
    render :json => params[:data]
  end
end