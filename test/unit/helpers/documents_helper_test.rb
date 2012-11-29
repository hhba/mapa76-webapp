require "test_helper"

class DocumentsHelperText < ActiveSupport::TestCase
  class MockView < ActionView::Base
    include DocumentsHelper
  end

  setup do
    @template = MockView.new
    @document = create :document
  end

  context "#thumbnail_url" do
    should "return the URL path to the thumbnail of the document" do
      @document.update_attributes :thumbnail_file => "my_thumb.png"

      url = @template.thumbnail_url(@document)
      assert_equal "#{Mapa76::Application.config.thumbnails_path}/my_thumb.png", url
    end

    context "document has not thumbnail" do
      should "return the URL path to the placeholder image" do
        @document.update_attributes :thumbnail_file => nil

        url = @template.thumbnail_url(@document)
        assert_equal "/assets/thumbnail_placeholder.png", url
      end
    end
  end

  context "#original_file_url" do
    should "return the URL path to the original uploaded file" do
      @document.update_attributes :original_file => "my_doc.pdf"

      url = @template.original_file_url(@document)
      assert_equal "#{Mapa76::Application.config.uploads_path}/my_doc.pdf", url
    end
  end

  context "#status" do
    should "return a Hash with the status of the document" do
      @document.update_attributes :percentage => 100, :category => "Veredicto"

      status = @template.status(@document)

      assert_equal @document.id, status[:id]
      assert_equal @document.title, status[:title]
      assert_equal @document.category, status[:category]
      assert_equal @document.percentage, status[:percentage]
      assert_equal @document.readable?, status[:readable]
      assert_equal @document.geocoded?, status[:geocoded]
      assert_equal @document.exportable?, status[:exportable]
      assert_equal @document.completed?, status[:completed]
      assert_equal @document.id.generation_time.strftime("%d/%m/%y"), status[:generation_time]
      assert_equal @template.thumbnail_url(@document), status[:thumbnail]
    end
  end
end
