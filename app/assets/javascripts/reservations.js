// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


var NewReservation = {
  init: function() {
    $('#month-of-year-selector a').click(function(ev) { NewReservation.monthChanged($(this)); });
    $('#day-of-month-selector a').click(function(ev) { NewReservation.dayChanged($(this)); });
  },
  monthChanged: function(atag) {
    var month = atag.text().trim();
    
    $('#reservation_starts_at_in_zone_2i option').filter(function() { return $(this).text().trim() == month; }).attr('selected', true);
    // TODO change this to use the calendar properly
    $('#reservation_ends_at_in_zone_2i option').filter(function() { return $(this).text().trim() == month; }).attr('selected', true);
    
    $('#month-of-year-selector li').removeClass('doms-selected');
    atag.closest('li').addClass('doms-selected');
    $('#month-of-year-label').text(month);
  },
  dayChanged: function(atag) {
    var day = atag.text().trim();
    
    $('#reservation_starts_at_in_zone_3i option').filter(function() { return $(this).text().trim() == day; }).attr('selected', true);
    // TODO change this to use the calendar properly
    $('#reservation_ends_at_in_zone_3i option').filter(function() { return $(this).text().trim() == day; }).attr('selected', true);
    
    $('#day-of-month-selector li').removeClass('doms-selected');
    atag.closest('li').addClass('doms-selected');
    $('#day-of-month-label').text(day);
  }
};

// Run this if we're on the right page
if ($('#day-and-time-selector').get(0)) {
  NewReservation.init();
}