$(document).on('turbolinks:load', function(){
  $('#input-comment').on('input', function () {
    if($(this).val().trim() != '') {
      $('#btn-submit-comment').removeAttr('disabled');
    } else {
      $('#btn-submit-comment').attr('disabled', true);
    }
  });
});
