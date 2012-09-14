class Api::RegistersController < ApplicationController
  def create
    # TODO: NOT SURE IF THIS IS WORKING FINE
    if register = Register.create(params)
      response.status = 201
      render :json => register
    else
      response.status = 405
      render :nothing => true
    end
  end
end
