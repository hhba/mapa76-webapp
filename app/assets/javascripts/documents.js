$(document).ready(function(){
  $(".with-scrollbar").mCustomScrollbar({
    mouseWheel: 5,
    scrollInertia: 250,
    advanced: { updateOnBrowserResize: true }
  });

  /*
  // Update scrollbar when changing tabs
  $(".document .nav a").live("click", function() {
    $(".with-scrollbar").mCustomScrollbar("update");
  });
  */

  /*
  // Auto-update documents state
  function checkDocumentsStatuses() {
    $.get("/documents/status", null, function(data){
      $('table.documents tbody').html(Mustache.render(template, {documents: data}));
    }, 'json');
    setTimeout(checkDocumentsStatuses, 15000 );
  }

  if($("table.documents").length){
    var template = $("#documentRowTemplate").html();
    checkDocumentsStatuses();
  }
  */

  /*
  // Load document context when clicking row
  $(".documents tbody tr").live("click", function(e) {
    var url = "/documents/" + $(this).data("id") + "/context.json";
    var template = $("#documentContext").html();
    $(this).siblings().removeClass("selected");
    $(this).addClass("selected");
    $("#document").html("").spin();
    $.getJSON(url, null, function(data) {
      $("#document").html(Mustache.render(template, data));
      $("#document .tablesorter").filter(function() {
        return $(this).find("tbody tr").length > 0;
      }).tablesorter({
        sortList: [[1,1]]
      });
      $(".with-scrollbar").mCustomScrollbar("update");
    }).error(function() {
      $("#document").html(Mustache.render($("#documentContextError").html()));
    });
  });
  // Stop row click propagation when clicking on the documents toolbar
  $(".documents tbody tr .tools").live("click", function(e) {
    e.stopPropagation();
  });
  */

  /*
  // Blacklist
  $(".blacklist a").live("click", function(event){
    event.preventDefault();
    var $this = $(this);
    var answer = confirm("Enviar " + $this.data("name") + "a la blacklist?");
    if(answer) {
      $.post($this.attr("href"), null, function(){
        $this.parents("tr").remove();
        $(".with-scrollbar").mCustomScrollbar("update");
      }, null);
    }
  });
  */
});
