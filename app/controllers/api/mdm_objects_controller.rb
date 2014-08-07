class Api::MdmObjectsController < ApplicationController
  skip_before_filter  :verify_authenticity_token 
  def save
     #we need a AR name
     klass = eval(params[:ar_name].capitalize)
     pkcols = MdmObject.find_by_name(params[:ar_name]).mdm_columns.select{|x| x.is_primary_key}.collect { |u| u.name }
     pkeys = params.select{|k,v| pkcols.include?(k)}
     begin
       @item = klass.find(pkeys.values)
     rescue
       @item = klass.new
     end
     klass.columns.each do | col |
       eval("@item.#{col.name}=params[col.name]")
     end
     @item.save!
     render :json => params[:data]
   end
   
  def index
     #we need a AR name
     klass = eval(params[:name].capitalize)
     @items = klass.find(:all)  #, :country => 'canada'))
     render :json => @items
   end   
end