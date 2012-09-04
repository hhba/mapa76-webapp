require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  context "Documents list and show" do
    setup do
      @document = create :document
    end

    should "Should list document's name" do
      get :index
      assert_response :success
      assert_template :index
      assert_not_nil assigns(:documents)
      assert_select 'li.title', @document.title
    end

    should "Show one document" do
      get :show, id: @document.id
      assert_response :success
      assert_template :show
      assert_not_nil assigns(:document)
      assert_select 'h1.title', @document.title
    end

    should "Import a new document" do
      get :new
      assert_response :success
      assert_template :new
      assert_select 'h1', "New document"
    end
  end
end
