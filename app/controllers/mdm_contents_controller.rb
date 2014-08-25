class MdmContentsController < ApplicationController

  
  before_filter :subdomain_view_path
   
   def subdomain_view_path
     @atest = "testing"
   end  
   
   
  def new
    @mdm_object= MdmObject.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def index_for_object
    @mdm_object= MdmObject.find_by_name(params[:name])
    klass = eval(params[:name].capitalize)
    @items = klass.find(:all)  #, :country => 'canada'))
    render :index_for_object
  end
  
  def form_for_object
    #should get in modelname
    #action (add,del,update)
    #if action in del,update we will also get
    #keys
    @mdm_object= MdmObject.find_by_name(params[:name])
    puts params[:keys]
    if params[:keys]
      puts "*" *80
      klass = eval(@mdm_object.name.capitalize)
      klass.connection
      begin
        @item = klass.find(params[:keys][0])
      rescue
        @item = klass.new
      end
    end
    if @mdm_object
      render :form_for_object
    else 
      render "not found!!"
    end
  end

  def show
  end
end