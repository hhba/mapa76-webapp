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
      assert_instance_of Array, Document.status
      status = Document.status.first

      assert_equal 100, status[:percentage]
      assert_equal @document.title, status[:title]
      assert_equal true, status[:geocoded]
      assert_equal 'Veredicto', status[:category]
      assert status[:generation_time]
      assert status[:thumbnail]
      assert status[:completed]
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
