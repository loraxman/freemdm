class MdmContentsController < ApplicationController

  def new
    @mdm_object= MdmObject.new

    respond_to do |format|
      format.html # new.html.erb
    end
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
      puts eval(@mdm_object.name.capitalize)
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