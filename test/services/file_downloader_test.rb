require 'test_helper'

class FileDownladerTest < ActiveSupport::TestCase
  setup do
    @link = "http://examle.org/condenas_jujuy.pdf"
    FakeWeb.register_uri = :get, @link, {
      body: File.open("test/support/condenas_jujuy.pdf").read,
      content_lenth: 1000,
      content_type: "application/pdf"
    }
  end

  should "provide filename" do
    file_dowloader = FileDownloader.new @link
    assert_equal file_dowloader.filename, "condenas_jujuy.pdf"
  end

  should "Download a file" do
    file_dowloader = FileDownloader.new @link
    assert_instance_of Tempfile, file_dowloader.download
  end
end
