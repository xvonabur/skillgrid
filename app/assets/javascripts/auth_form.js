$(function () {
    $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
    });
});

$(document).ready(function () {
  $('#user_birthday').datepicker({
    startDate: '-100y'
  });
});