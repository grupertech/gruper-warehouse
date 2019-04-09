$(document).ready(function() {
  // Initialize datepicker for bootstrap 4
  $('#startUnavailRoom').datepicker({
    showOtherMonths: true,
    format: 'dd/mm/yyyy',
    uiLibrary: 'bootstrap4'
  });

  $('#endUnavailRoom').datepicker({
    showOtherMonths: true,
    format: 'dd/mm/yyyy',
    uiLibrary: 'bootstrap4'
  });

  $('#check_in').datepicker({
    showOtherMonths: true,
    format: 'dd/mm/yyyy',
    uiLibrary: 'bootstrap4'
  });

  $('#check_out').datepicker({
    showOtherMonths: true,
    format: 'dd/mm/yyyy',
    uiLibrary: 'bootstrap4'
  });

  // Validation Room Form
  $('#the_room').validate();
});