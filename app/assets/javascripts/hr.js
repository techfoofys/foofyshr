function get_profile(user_id) {
  // var user_id = $('.user_name_nav li.active')[0].getAttribute('data-userid');
  var url = '/hr/get_user_profile?user_id=' + user_id ;
 $.get(url, function(data) {

   $('#view_user_profile').html(data); } ).done(function() {
     
    $('#show_profile').modal('show');
    //Image popup
    $('.img-pop').on('click',function(){
        var sr=$(this).attr('src');
       $('#mimg').attr('src',sr);
       $('#myPopupModal').modal('show');
    });
  });

}
