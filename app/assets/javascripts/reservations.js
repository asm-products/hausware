// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


var NewReservation = {
  init: function() {
    $('#month-of-year-selector a').click(function(ev) { NewReservation.monthChanged($(this)); });
    $('#day-of-month-selector a').click(function(ev) { NewReservation.dayChanged($(this)); });
    $('#time-of-day-selector a').click(function(ev) { NewReservation.timeChanged($(this)); });
    $('#duration-in-hours-selector a').click(function(ev) { NewReservation.durationChanged($(this)); });
  },
  _leadingPadding: function(n, width, z) {
    z = z || '0';
    n = n + '';
    return n.length >= width ? n : new Array(width - n.length + 1).join(z) + n;
  },
  // Usage example: NewReservation.dateTimeSelectValue('starts_at_in_zone')
  dateTimeSelectValue: function(railsAttributeName) {
    var value = new Date(
      parseInt($('#reservation_'+railsAttributeName+'_1i').val()), // year
      parseInt($('#reservation_'+railsAttributeName+'_2i').val()) - 1, // month, but 0 based
      parseInt($('#reservation_'+railsAttributeName+'_3i').val()), // day
      parseInt($('#reservation_'+railsAttributeName+'_4i').val()), // hours
      parseInt($('#reservation_'+railsAttributeName+'_5i').val()), // minutes
      0,
      0
    );
    return value;
  },
  durationInHoursValue: function() {
    var stringValue = $('#duration-in-hours-label').text().trim();
    return parseInt(stringValue.split(" ")[0]);
  },
  // Assuming starts_at has been set correctly, recalculates correct end time based on duration
  recalculatedEndsAtDate: function() {
    var startsAt = NewReservation.dateTimeSelectValue('starts_at_in_zone');
    var duration = NewReservation.durationInHoursValue();
    return new Date(startsAt.getTime() + (duration*60*60*1000)); 
  },
  setDateTimeSelectValue: function(railsAttributeName, dateValue) {
    $('#reservation_'+railsAttributeName+'_1i').val(dateValue.getFullYear().toString());
    $('#reservation_'+railsAttributeName+'_2i').val((dateValue.getMonth() + 1).toString()); // month, but 1 based
    $('#reservation_'+railsAttributeName+'_3i').val(dateValue.getDate().toString());
    $('#reservation_'+railsAttributeName+'_4i').val(NewReservation._leadingPadding(dateValue.getHours(), 2));
    $('#reservation_'+railsAttributeName+'_5i').val(NewReservation._leadingPadding(dateValue.getMinutes(), 2));
  },
  setRecalculatedEndsAtDate: function() {
    NewReservation.setDateTimeSelectValue('ends_at_in_zone', NewReservation.recalculatedEndsAtDate());
  },
  monthChanged: function(atag) {
    var month = atag.text().trim();
    
    $('#reservation_starts_at_in_zone_2i option').filter(function() { return $(this).text().trim() == month; }).attr('selected', true);
    NewReservation.setRecalculatedEndsAtDate();
    
    $('#month-of-year-selector li').removeClass('doms-selected');
    atag.closest('li').addClass('doms-selected');
    $('#month-of-year-label').text(month);
  },
  dayChanged: function(atag) {
    var day = atag.text().trim();
    
    $('#reservation_starts_at_in_zone_3i option').filter(function() { return $(this).text().trim() == day; }).attr('selected', true);
    NewReservation.setRecalculatedEndsAtDate();
    
    $('#day-of-month-selector li').removeClass('doms-selected');
    atag.closest('li').addClass('doms-selected');
    $('#day-of-month-label').text(day);
  },
  timeChanged: function(atag) {
    var time = atag.text().trim();
    var timesplit = time.split(":");
    var hour12string = timesplit[0];
    var hour = parseInt(hour12string);
    var hour24string;
    var minute = timesplit[1].substring(0,timesplit[1].length-2);
    var meridian = timesplit[1].substring(timesplit[1].length-2);
    
    // Convert to 24 hour clock
    if (meridian.toLowerCase() == 'pm' && hour < 12) {
      hour += 12;
    }
    hour24string = NewReservation._leadingPadding(hour, 2);
    
    $('#reservation_starts_at_in_zone_4i').val(hour24string);
    $('#reservation_starts_at_in_zone_5i').val(minute);
    
    var startsAt = NewReservation.dateTimeSelectValue('starts_at_in_zone');
    NewReservation.setRecalculatedEndsAtDate();
    
    $('#time-of-day-selector li').removeClass('doms-selected');
    atag.closest('li').addClass('doms-selected');
    $('#time-of-day-label').text(time);
  },
  durationChanged: function(atag) {
    var duration = atag.text().trim();
    
    $('#duration-in-hours-selector li').removeClass('doms-selected');
    atag.closest('li').addClass('doms-selected');
    $('#duration-in-hours-label').text(duration);
    
    NewReservation.setRecalculatedEndsAtDate();
  }
};

// Run this if we're on the right page
if ($('#day-and-time-selector').get(0)) {
  NewReservation.init();
}