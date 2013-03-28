class projects.Timeliner
  constructor: (container)->
    @container = container
    @projectId = @container.data("project-id")
    @initialize()

  initialize: ->
    @getData()
  bind: ->
  render: ->
  process: (response)->
    @name = response.name
    @description = response.descriptin
    console.log(response)

  getData: ->
    $.get "/api/v1/projects/#{@projectId}/timeline", null, ((response) =>
      @process(response)
    ), "json"
