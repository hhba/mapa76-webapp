require 'test_helper'

class PeopleControllerTest < ActionController::TestCase
  context "People's controller" do
    setup do
      @person = create :person
    end

    should "Add a person to the blacklist" do
      post :blacklist, :id => @person.id
      status = JSON.parse(@response.body)

      assert_response :success
      assert_equal 1, Blacklist.count
    end
  end
end
