class projects.Project
  constructor: (projectId) ->
    @projectId = projectId
    @initialize()

  initialize: ->
    @bind()
    @getDocumentData()

  bind: ->
    self = @
    @container = $("#documents")
    @template = _.template $("#documentsList").html()
    @container.on "click", "i.remove", (event) ->
      event.preventDefault()
      self.handleClick(@)

  render: ->
    @container.html(
      @template(
        projectId: @projectId
        documents: @documentsJSON
      )
    )

  getDocumentData: ->
    $.get "/projects/#{@projectId}", null, ((response) =>
      @documentsJSON = response
      @render()
    ), 'json'

  handleClick: (element) ->
    documentId = $(element).data "document-id"
    $.post("/projects/#{@projectId}/remove_document",
      document_id: documentId
      _method: "delete",
      null,
      'json'
    )
    $(element).parents("li").remove()

class projects.ProjectsCollection
  constructor: (container) ->
    @container = container
    @initialize()

  initialize: ->
    @projectsJSON = @container.data("projects")
    @bind()
    @render()

  bind: ->
    self = @
    @container.on "click", "a", (event) ->
      event.preventDefault()
      self.handleClick(@)
    @template = _.template $("#projectsList").html()

  render: ->
    @container.html(
      @template(
        projects: @projectsJSON
      )
    )

  handleClick: (element)->
    new projects.Project $(element).data("project-id")

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
  if $(".add_documents").length
    addDocumentsElement = $(".add_documents")

    otherDocumentsList = new projects.OtherDocumentsList(
      addDocumentsElement.data("project-id")
      addDocumentsElement.data("other-documents")
      $(".notadded")
    )

    ownDocumentsList = new projects.OwnDocumentsList(
      addDocumentsElement.data("project-id")
      addDocumentsElement.data("own-documents")
      $(".added")
    )

    otherDocumentsList.opposite = ownDocumentsList
    ownDocumentsList.opposite = otherDocumentsList

  if $("#projects").length
    projectsCollection = new projects.ProjectsCollection $("#projects")

