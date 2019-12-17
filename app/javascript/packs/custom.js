$(function() {
  $('[data-toggle="tooltip"]').tooltip();
});

$(function() {
  $('[data-toggle="popover"]').popover();
});

$('#myModal').on('shown.bs.modal', function () {
  $('#myInput').trigger('focus')
});
