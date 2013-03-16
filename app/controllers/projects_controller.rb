class ProjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @projects = current_user.projects
  end

  def show
    @project = current_user.projects.find params[:id]
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build params[:project]
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def add_documents
    @project = current_user.projects.find params[:id]
    @own_documents = @project.documents
    @public_documents = Document.public.without(@own_documents)
    @private_documents = Document.private_for(current_user).without(@own_documents)
  end

  def add_document
    render :json => params[:document_id].to_json
  end
end
