date_format = event.all_day_event? ? '%Y-%m-%d' : '%Y-%m-%dT%H:%M:%S'

json.id "event_#{event.id}"
json.title event.title
json.start_event event.start_event.strftime(date_format)
json.end_event event.end_event.strftime(date_format)

json.color event.color unless event.color.blank?
json.allDay event.all_day_event? ? true : false

json.update_url admin_event_url(event, method: :patch)
json.edit_url edit_admin_event_url(event)