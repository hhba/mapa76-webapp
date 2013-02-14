class DocumentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @documents = Document.all
  end

  def search
    @search = Document.tire.search do |s|
      s.fields :id
      s.query do |q|
        params[:q].blank? ? q.all : q.string(params[:q])
      end
      s.highlight :title, :heading, *(1..10000).map(&:to_s)
    end
    @results = @search.results.map do |item|
      [item, item.load]
    end
  end

  def new
    @document = Document.new
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
    @document = Document.find(params[:id])
    if url = @document.original_file_url
      redirect_to url
    else
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end
