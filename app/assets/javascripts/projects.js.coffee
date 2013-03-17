class projects.DocumentList
  constructor: (projectId, documents, container)->
    @documents = documents || []
    @container = container
    @projectId = projectId
    @initialize()

  initialize: ->
    @bind()
    @render()

  bind: ->
    self = @
    @template = _.template $("#documentList").html()
    @container.on "click", "i", (event) ->
      event.preventDefault()
      self.handleClick(@)

  render: ->
    @container.html(
      @template(
        messages: @messages()
        documents: @documents
      )
    )

  handleClick: (element) ->
    document = @findDocumentById($(element).hide().data("id"))
    @removeDocument(document)
    @opposite.addDocument(document)
    @update(document)

  addDocument: (document) ->
    @documents.push document
    @render()

  removeDocument: (document) ->
    @removeDocumentById(document._id)
    @render()

  removeDocumentById: (id) ->
    @documents = _.filter @documents, (document)->
      document._id isnt id

  findDocumentById: (id) ->
    _.find @documents, (document) ->
      document._id is id

class projects.OtherDocumentsList extends projects.DocumentList
  update: (document) ->
    $.post "/projects/#{@projectId}/add_document",
      document_id: document._id

  messages: ->
    {title: "Documentos públicos y privados", tooltip: "Agregar"}

class projects.OwnDocumentsList extends projects.DocumentList
  update: (document) ->
    $.post "/projects/#{@projectId}/remove_document",
      document_id: document._id
      _method: "delete"

  messages: ->
    {title: "Documentos del proyecto", tooltip: "Remover"}

$ ->
  return unless $(".add_documents").length

  addDocumentsElement = $(".add_documents")

  window.otherDocumentsList = new projects.OtherDocumentsList(
    addDocumentsElement.data("project-id")
    addDocumentsElement.data("other-documents")
    $(".notadded")
  )

  window.ownDocumentsList = new projects.OwnDocumentsList(
    addDocumentsElement.data("project-id")
    addDocumentsElement.data("own-documents")
    $(".added")
  )

  otherDocumentsList.opposite = ownDocumentsList
  ownDocumentsList.opposite = otherDocumentsList
