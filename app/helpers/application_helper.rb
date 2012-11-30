module ApplicationHelper
  def current_project
    require 'ostruct'
    project = OpenStruct.new
    project.name = "ESMA"
    project
  end

  def current_document
    require 'ostruct'
    document = OpenStruct.new
    document.name = "Fundamentos"
    document
  end
end
