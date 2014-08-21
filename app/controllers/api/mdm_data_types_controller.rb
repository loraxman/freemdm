class Api::MdmDataTypesController < ApplicationController
  skip_before_filter  :verify_authenticity_token 

  def index
    @mdm_datatypes = MdmDataType.all
    render :json => @mdm_datatypes.to_json()
  end
  

end