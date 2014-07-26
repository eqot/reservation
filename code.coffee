doGet = (e) ->
  return HtmlService.createHtmlOutputFromFile 'index'

checkData = (frm) ->
  mail = frm['mail']
  name = frm['name']
  date = new Date(frm['date'])
  time_s = new Date(frm['time_s'])
  time_e = new Date(frm['time_e'])

  # Logger.log(date)

  cal = CalendarApp.getCalendarById('__ID__')

  evts = cal.getEventsForDay(date)
  if evts.length > 0
    frmdaystr = date.getYear() + '-' +  date.getMonth() + '-' + date.getDate()
    evtday = evts[evts.length - 1].getAllDayStartDate()
    evtdaystr = evtday.getYear() + '-' +  evtday.getMonth() + '-' + evtday.getDate()

    if frmdaystr is evtdaystr
      return '申し訳ありません。その日は既に予約済みです。'

  cal.createEvent name, time_s, time_e,
    description: "#{name} (#{mail})"
    guests: mail

  return = date.getYear() + "年" + (date.getMonth() + 1) + "月" + date.getDate() + '日に予約しました。（ブラウザーをリロードすると、カレンダーが更新されます）'
