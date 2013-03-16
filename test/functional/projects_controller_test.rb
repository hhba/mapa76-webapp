require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  context "Display information about a single project" do
    setup do
      @user = FactoryGirl.create :user
      @document_1 = FactoryGirl.create :document
      @document_2 = FactoryGirl.create :document
      @project = FactoryGirl.create :project, :user_ids => [@user.id]
      @project.documents << @document_1
      sign_in @user
    end

    should "Should list project's name" do
      get :show, :id => @project.id
      assert_response :success
      assert_template :show
      assert_not_nil assigns(:project)
    end

    should "Add a document to a project"
      # -> {
      #   post :add_document, id: @project.id, document_id: @document_2.id
      # }.should change(@project.documents, :count)
    should "Remove a document from a project"
  end
end
