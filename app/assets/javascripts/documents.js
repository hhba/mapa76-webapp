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
});
