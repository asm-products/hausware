// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

var ReceptionReservationsIndex = {
  init: function() {
    $('.checkin-now-button').click(function(ev) {
      ev.stopPropagation();
      var a = $(this);
      if (confirm(a.attr('data-reservation-checkinnow-prompt'))) {
        $.post(a.attr('data-reservation-checkinnow-path'), {'_method': 'put'}, function(data) {
          window.location.reload();
        }, 'json');
      }
    });
  }
};

if ($('.checkin-now-button').get(0)) {
  ReceptionReservationsIndex.init();
}