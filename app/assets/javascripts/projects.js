function get_instalment_details(project_id) {
  var url = '/instalments/get_instalments?project_id=' + project_id ;
   $.get(url, function(data) {
     $('#view_instalments').html(data); } ).done(function() {
       $('#instalment_detail_Modal').modal('show');
    });

}
