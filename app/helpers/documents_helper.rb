module DocumentsHelper
  def thumbnail_url(document)
    if document.thumbnail_file
      "#{Mapa76::Application.config.thumbnails_path}/#{CGI.escape(document.thumbnail_file)}"
    else
      asset_path("thumbnail_placeholder.png")
    end
  end

  def status(document)
    {
      id:              document._id,
      heading:         document.heading,
      category:        document.category,
      percentage:      document.percentage,
      readable:        document.readable?,
      geocoded:        document.geocoded?,
      exportable:      document.exportable?,
      completed:       document.completed?,
      generation_time: document.id.generation_time.strftime("%d/%m/%y"),
      thumbnail:       thumbnail_url(document),
    }
  end
end
