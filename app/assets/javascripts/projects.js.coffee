$ ->
  return unless $(".add_documents").length

  $(".add_documents").on "click", ".notadded li", ->
    self = $(@)
    project_id = $(".add_documents").data("id")
    $.post "/projects/#{project_id}/add_document",
      document_id: self.data("id")
    , (data) ->
      console.log(data)
