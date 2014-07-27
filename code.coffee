doGet = (e) ->
  return HtmlService.createHtmlOutputFromFile 'index'

checkData = (form) ->
  name = form.name
  mail = form.mail
  date = new Date form.date
  time_s = new Date form.time_s
  time_e = new Date form.time_e

  # Logger.log(date)

  cal = CalendarApp.getCalendarById('__ID__')

  events = cal.getEvents time_s, time_e
  if events.length > 0
    return '先約があるため、予約できませんでした。'

  cal.createEvent name, time_s, time_e,
    description: "#{name} (#{mail})"
    guests: mail

  return '予約しました。(ブラウザーをリロードすると、カレンダーが更新されます)'
