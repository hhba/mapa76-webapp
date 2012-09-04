require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  context "Document" do
    setup do
      @document = create :document
      @document.update_attributes :percentage => 100, :category => 'Veredicto'
    end

    should "Validate presence and uniqueness of title" do
      validate_presence_of(:title)
      validate_uniqueness_of(:title)
    end

    should "Return a hash with the status on each document" do
      assert_equal 100, @document.status[:percentage]
      assert_equal @document.title, @document.status[:title]
      assert_equal true, @document.status[:geocoded]
      assert_equal 'Veredicto', @document.status[:category]
    end

    should "generate CSV with all the people"
    should "Export registers as CSV"
  end
end
