var initialize_calendar;
initialize_calendar = function() {
  $('.calendar').each(function() {
    var calendar = $(this);
    calendar.fullCalendar({
      header: {
        left: 'prev,next today',
        center: 'title',
        right: 'month,agendaWeek,agendaDay'
      },

      selectable: true,
      selectHelper: true,
      editable: true,
      eventLimit: true,
      eventSources: [
        'events.json',
        'recurring_events.json'
      ],

      select: function(start, end) {
        $.getScript('events/new', function() {
          $('#event_date_range').val(moment(start).format("MM/DD/YYYY HH:mm") + ' - ' + moment(end).format("MM/DD/YYYY HH:mm"))
          date_range_picker();
          $('.start_hidden').val(moment(start).format('YYYY-MM-DD HH:mm'));
          $('.end_hidden').val(moment(end).format('YYYY-MM-DD HH:mm'));
        });

        calendar.fullCalendar('unselect');
      },

      eventDrop: function(event, delta, revertFunc) {
        event_data = { 
          event: {
            id: event.id,
            start: event.start_event.format(),
            end: event.end_event.format()
          }
        };

        $.ajax({
            url: event.update_url,
            data: event_data,
            type: 'PATCH'
        });
      },

      eventClick: function(event, jsEvent, view) {
        $.getScript(event.edit_url, function() {
          $('#event_date_range').val(moment(event.start_event).format("MM/DD/YYYY HH:mm") + ' - ' + moment(event.end_event).format("MM/DD/YYYY HH:mm"));
          date_range_picker();
          $('.start_hidden').val(moment(event.start_event).format('YYYY-MM-DD HH:mm'));
          $('.end_hidden').val(moment(event.end_event).format('YYYY-MM-DD HH:mm'));
        });
      }
    });
  })
};

$(document).on('turbolinks:load', initialize_calendar);