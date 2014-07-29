class MdmContentsController < ApplicationController

  def new
    @mdm_object= MdmObject.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def form_for_object
    @mdm_object= MdmObject.find_by_name(params[:name])

    render :form_for_object
  end

  def show
  end
end