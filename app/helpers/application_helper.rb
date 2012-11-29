module ApplicationHelper
  def original_file_url(document)
    if document.original_file
      "/#{Mapa76::Application.config.uploads_path}/#{CGI.escape(document.original_file)}"
    end
  end

  def thumbnail_url(document)
    if document.thumbnail_file
      "#{Mapa76::Application.config.thumbnails_path}/#{CGI.escape(document.thumbnail_file)}"
    end
  end

  def thumbnail_tag(document, opts={})
    url = document.thumbnail_file ? thumbnail_url(document) : asset_path("thumbnail_placeholder.png")
    image_tag(url, opts)
  end
end
