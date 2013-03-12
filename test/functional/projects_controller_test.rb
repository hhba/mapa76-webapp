require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  context "Display information about a single project" do
    setup do
      @user = FactoryGirl.create :user
      @project = FactoryGirl.create :project, :user_ids => [@user.id]
      sign_in @user
    end

    should "Should list project's name" do
      get :show, :id => @project.id
      assert_response :success
      assert_template :show
      assert_not_nil assigns(:project)
    end
  end
end
