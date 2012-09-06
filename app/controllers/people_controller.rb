class PeopleController < ApplicationController
  def blacklist
    render :json => Person.find(params[:id]).blacklist
  end
end
