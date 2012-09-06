$(document).ready(function(){
  function checkDocumentsStatuses(){
    $.get("/documents/status", null, function(data){
      $('table.documents tbody').html(Mustache.render(template, {documents: data}));
    }, 'json');
    setTimeout(checkDocumentsStatuses, 15000 );
  }
  if($("table.documents").length){
    var template = $("#documentRowTemplate").html();
    checkDocumentsStatuses();
  }
  $(".documents tbody tr").live("click", function(e) {
    $(this).siblings().removeClass("selected");
    $(this).addClass("selected");
    var url = "/documents/" + $(this).data("id") + "/context.json";
    var template = $("#documentContext").html();
    $("#document").html("").spin();
    $(".with-scrollbar").mCustomScrollbar("update");

    $.getJSON(url, null, function(data) {
      $("#document").html(Mustache.render(template, data));
      $("#document .tablesorter").filter(function() {
        return $(this).find("tbody tr").length > 0;
      }).tablesorter({
        sortList: [[1,1]]
      });
    }).error(function() {
      $("#document").html(Mustache.render($("#documentContextError").html()));
    });
  });
});
