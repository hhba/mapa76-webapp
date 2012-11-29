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

    should "Generate context" do
      register = create :register, document: @document
      person = create :person
      @document.people << person

      assert_equal register.who, @document.context[:registers].first[:who]
      assert_equal @document.title, @document.context[:title]
      assert_equal person.name, @document.context[:people].first[:name]
    end

    should "generate CSV with all the people"
    should "Export registers as CSV"
  end
end
