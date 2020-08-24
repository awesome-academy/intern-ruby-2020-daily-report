$(document).on('turbolinks:load', function(){
  var userName = $('#edit-name-account').val();
  var userEmail = $('#edit-email-account').val();

  $('#input-avatar').change(function() {
    if (this.files && this.files[0]) {
      var reader = new FileReader();
      reader.onload = function(e) {
        $('#avatar-img').attr('src', e.target.result);
      }
      reader.readAsDataURL(this.files[0]);
    }
    let avatar = $(this).val().trim();
    let email = $('#edit-email-account').val().trim();
    let name = $('#edit-name-account').val().trim();
    disableSubmitBtn(name, email, avatar);
  });

  $('#edit-name-account').on('input', function() {
    let name = $(this).val().trim();
    let email = $('#edit-email-account').val().trim();
    let avatar = $('#input-avatar').val();
    disableSubmitBtn(name, email, avatar);
  })

  $('#edit-email-account').on('input', function() {
    let email = $(this).val().trim();
    let name = $('#edit-name-account').val().trim();
    let avatar = $('#input-avatar').val();
    disableSubmitBtn(name, email, avatar);
  })

  function disableSubmitBtn(name, email, avatar) {
    if (name == '' || email == '') {
      $('#btn-submit-edit-account').attr('disabled', true);
    } else if (name == userName && email == userEmail && avatar == '') {
      $('#btn-submit-edit-account').attr('disabled', true);
    } else {
      $('#btn-submit-edit-account').removeAttr('disabled');
    }
  }
});
