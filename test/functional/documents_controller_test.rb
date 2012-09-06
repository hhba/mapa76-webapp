require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  context "Documents list and show" do
    setup do
      name_entity = create :name_entity
      name_entity_1 = create :name_entity
      date_entity = create :date_entity
      where_entity = create :where_entity
      @document = create :document
      @register = create :register, document: @document,
                         who: [name_entity.id], what: "nacio",
                         when: [date_entity.id], where: [where_entity.id],
                         to_who: [name_entity_1.id]
    end

    should "Should list document's name" do
      get :index
      assert_response :success
      assert_template :index
      assert_not_nil assigns(:documents)
      assert_select 'td div.title', @document.title
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
      assert_select 'h1', "Importar documento"
    end

    should "Retrieve a JSON with the statuses" do
      @document.update_attribute :percentage, 100
      get :status, :format => :json
      status = JSON.parse(@response.body).last

      assert_response :success
      assert_equal @document.title, status['title']
      assert_equal 100, status['percentage']
    end

    should "Retrieve a JSON with the context" do
      get :context, :format => :json, :id => @document.id
      status = JSON.parse(@response.body)

      assert_response :success
      assert_equal @document.title, status["title"]
      assert_instance_of Array, status["registers"]
    end

    should "Show comb page" do
      get :comb, :id => @document.id

      assert_response :success
    end
  end
end
