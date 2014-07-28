version = '__VERSION__'
time = '__TIME_STAMP__'

doGet = (e) ->
  return HtmlService.createHtmlOutputFromFile 'index'

checkData = (form) ->
  if form.cmd is 'delete'
    removeEvent form
  else
    addEvent form

addEvent = (form) ->
  name = form.name
  mail = form.mail
  time_s = new Date form.time_s
  time_e = new Date form.time_e
  resource = form.resource

  cal = CalendarApp.getCalendarById('__ID__')

  events = cal.getEvents time_s, time_e
  for event in events
    if event.getTitle() is resource
      return '先約があるため、予約できませんでした。'

  cal.createEvent resource, time_s, time_e,
    description: "#{name} (#{mail})"
    guests: mail

  return '予約しました。(ブラウザーをリロードすると、カレンダーが更新されます)'

removeEvent = (form) ->
  name = form.name
  mail = form.mail
  time_s = new Date form.time_s
  time_e = new Date form.time_e
  resource = form.resource

  cal = CalendarApp.getCalendarById('__ID__')

  events = cal.getEvents time_s, time_e
  for event in events
    # if event.getTitle() is resource and event.getStartTime() is time_s and event.getEndTime() is time_e and event.getDescription() is "#{name} (#{mail})"
    if event.getTitle() is resource and event.getDescription() is "#{name} (#{mail})"
      event.deleteEvent()

      return '削除しました。(ブラウザーをリロードすると、カレンダーが更新されます)'

  return '該当する予約がなかったため、削除できませんでした。'
