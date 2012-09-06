# encoding: utf-8
require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  context "Populate people" do
    setup do
      patty1  = create :named_entity, text: "Luis Abelardo Patty"
      patty2  = create :named_entity, text: "Luis Ableardo Patty"
      videla1 = create :named_entity, text: "Jorge Rafael Videla"

      @document = create :document
      @duplicates = [[patty1, patty2], [videla1]]
    end

    should "Add one person per group of duplicates"
    should "not create a new person if it's already stored"
    should "search for all the posibilities when verifying it's not already in the database"
  end

  context "Add new person" do
    setup do
      @p1 = create :person, name: "Luciano Benjamín MenÉndez", tags: ['procesados']
      @p2 = create :person, name: "Eduardo Massera", tags: ['procesados', 'condenados', 'condenados']
    end

    should "Not add an existing person" do
      Person.add "Luciano Benjamín MenÉndez", tag: 'condenados'

      assert_equal 2, Person.first.tags.length
    end

    should "have unique tags" do
      assert_equal 2, @p2.tags.length
    end
    should "Test full_name"
    should "Test where a person has been mentioned"
    should "Test that I am storing normalized names"
  end

  context 'Blacklist' do
    setup do
      @person = create :person, name: "Policia Federal"
      @person.blacklist
    end

    should "not find the user once it was marked as blacklist" do
      assert_raise Mongoid::Errors::DocumentNotFound do
        Person.find(@person.id)
      end
    end
  end
end
