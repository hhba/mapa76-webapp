require 'test_helper'

class PersonTest < ActiveSupport::TestCase
  context "Populate people" do
    setup do
    end

    should "Add one person per group of duplicates"
    should "not create a new person if it's already stored"
    should "search for all the posibilities when verifying it's not already in the database"
  end
end
