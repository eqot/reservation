doGet = (e) ->
  return HtmlService.createHtmlOutputFromFile 'index'

checkData = (form) ->
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
