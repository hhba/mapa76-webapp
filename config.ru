# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

map "/" do
  run Mapa76::Application
end

if Rails.env == "production"
  map "/thumbs" do
    run Rack::Directory.new(File.join(Rails.root, "public", Mapa76::Application.config.thumbnails_path))
  end
end
