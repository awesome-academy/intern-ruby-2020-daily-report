$(document).on('turbolinks:load', function(){
  $('.div-create-btn button.exist-report').on('click', function() {
    alert(I18n.t('js.create_reports.exist_report'));
  })
  $('.div-create-btn button.no-division').on('click', function() {
    alert(I18n.t('js.create_reports.no_division'));
  })
});
