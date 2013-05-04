require 'test_helper'

class FileDownladerTest < ActiveSupport::TestCase
  setup do
   @link = "http://malev.com.ar/images/rss-logo.png"
  end

  should "provide filename" do
    file_dowloader = FileDownloader.new @link
    assert_equal file_dowloader.filename, "rss-logo.png"
  end

  should "Download a file" do
    file_dowloader = FileDownloader.new @link
    assert_instance_of Tempfile, file_dowloader.download
  end
end
