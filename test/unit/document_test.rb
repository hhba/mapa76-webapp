require 'test_helper'

class DocumentTest < ActiveSupport::TestCase
  context "Document" do
    setup do
    end
    should "Validate presence and uniqueness of title" do
      validate_presence_of(:title)
      validate_uniqueness_of(:title)
    end
    should "generate CSV with all the people"
    should "Export registers as CSV"
  end
end
