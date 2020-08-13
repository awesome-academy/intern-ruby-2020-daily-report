$(document).on('turbolinks:load', function(){
  $('#input-email-searching').on('input', function() {
    if ($(this).val().trim() != '') {
      $('#user-searching-result').show();
      $.ajax({
        url: '/manager/users/search',
        data: {key: $(this).val()},
        dataType: 'json',
        success: function(result){
          let render_result = '';
          for(let i=0; i<result.length; i++) {
            render_result += '<div class=\'box-search-user-result\'><a href=\'/manager/users/' + result[i].id + '\' class=\'link-search-user-result\'>' + result[i].email + '</a></div>';
          }
          $('#user-searching-result').html(render_result);
        }});
    } else {
      $('#user-searching-result').html('');
      $('#user-searching-result').hide();
    }
  })
});
