class Api::MdmModelsController < ApplicationController
  
  def show
    @mdm_model = MdmModel.find(params[:id])
    render :json => @mdm_model 
  end
end