require 'test_helper'

class DocumentsCreatorTest < ActiveSupport::TestCase
  setup do
    temp_file = Tempfile.new "document"
    temp_file.write("document content")
    uploaded_file = Rack::Test::UploadedFile.new(temp_file.path, "text/plain")

    @normal_document_params = {
      title: "Title",
      description: "desciption",
      file: uploaded_file
    }
    @invalid_params = {
      title: "Title",
      description: "desciption"
    }
    @multiple_documents_params = {
      files: [
        "https://dl.dropboxusercontent.com/1/view/q10jqqxrpfyxl4x/2011.pdf",
        "https://dl.dropboxusercontent.com/1/view/q10jqqxrpfyxl4x/2012.pdf"
      ] 
    }
    @single_document_params = {
      files: [
        "https://dl.dropboxusercontent.com/1/view/q10jqqxrpfyxl4x/2011.pdf"
      ] 
    }
  end

  should "Create a document uploading the file" do
    documents_creator = DocumentsCreator.new @normal_document_params

    assert documents_creator.valid?
    assert_difference("Document.count", 1) do
      documents_creator.save
    end
  end

  should "Not create a document with invalid params" do
    documents_creator = DocumentsCreator.new @invalid_params

    assert_equal false, documents_creator.valid?
    assert_equal false, documents_creator.save
  end

  #should "Create a single dropbox document with valid params" do
    #documents_creator = DocumentsCreator.new @single_document_params

    #assert documents_creator.valid?
    #assert_difference(Document.count, 1) do
      #documents_creator.save
    #end
  #end

  #should "Not create document with invalid params" do
    #documents_creator = DocumentsCreator.new @invalid_params
    #assert_equal documents_creator.valid?, false
    #assert_equal documents_creator.save, false
    #assert_instance_of documents_creator.errors, ActiveModel::Errors
  #end
  
  #should "Create a group of documents" do
    #documents_creator = DocumentsCreator.new @multiple_documents_params
    #assert documents_creator.valid?
    #assert_difference(Document.count, 2) do
      #documents_creator.save
    #end
  #end
end
