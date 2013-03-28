class DocumentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create]

  def index
    @page = params[:page] || 1
    @search = Document.tire.search(page: @page, per_page: 10) do |s|
      s.fields :id
      s.query do |q|
        params[:q].blank? ? q.all : q.string(params[:q])
      end
      if params[:mine].to_i == 1
        s.filter :term, user_id: [current_user.id]
      end
      s.highlight :title, *(1..10000).map(&:to_s)
    end
    @results = @search.results.map do |item|
      [item, item.load]
    end
    @projects = current_user ? current_user.projects : []
  end

  def new
    @document = Document.new
  end

  def create
    file = params[:document].delete(:file)
    @document = Document.new(params[:document])
    @document.original_filename = file.original_filename
    @document.file = file.path

    if @document.save
      redirect_to :action => :index
    else
      #flash[:error] = @document.errors
      redirect_to :back
    end
  end

  def show
    @document = Document.find(params[:id])
  end

  def status
    render :json => Document.all.map { |d| view_context.status(d) }
  end

  def context
    document = Document.find(params[:id])
    render :json => document.context
  end

  def comb
    @document = Document.find(params[:id])
    @pages = @document.pages.asc(:_id).first
    @empty_pages = @document.pages.asc(:_id).only(:id, :num, :width, :height)
    @addresses = @document.addresses_found.select { |addr| addr.geocoded? }
    @center = @addresses.first
  end

  def download
    # TODO check if dumping to a temp file and sending that file is more
    # memory-efficient...
    @document = Document.find(params[:id])
    send_data @document.file.data, filename: @document.original_filename
  end

  def generate_thumbnail
    @document = Document.find(params[:id])

    # Create thumbnail file in public assets directory
    path = File.join(Rails.root, "public", request.path)
    if not File.exists?(path)
      File.open(path, "wb") do |fd|
        @document.thumbnail_file.each do |chunk|
          fd.write(chunk)
        end
      end
    end

    # FIXME For now, #send_data here, ideally this should be handled by the
    # assets server (e.g. nginx).
    send_data open(path), filename: request.path
  rescue Mongoid::Errors::DocumentNotFound
    render :text => nil, :status => 404
  end
end
