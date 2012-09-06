class DocumentsController < ApplicationController
  def index
    @documents = Document.all
  end

  def new
    @document = Document.new
  end

  def show
    @document = Document.find(params[:id])
  end

  def status
    render :json => Document.status
  end

  def context
    document = Document.find(params[:id])
    render :json => document.context
  end
end
