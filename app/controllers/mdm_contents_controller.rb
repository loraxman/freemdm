class MdmContentsController < ApplicationController

  def new
    @mdm_object= MdmObject.first

    respond_to do |format|
      format.html # new.html.erb
    end
  end

end