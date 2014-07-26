doGet = (e) ->
  return HtmlService.createHtmlOutputFromFile 'index'

checkData = (frm) ->
  mail = frm['mail']
  name = frm['name']
  date = new Date(frm['date'])

  # Logger.log(date)

  cal = CalendarApp.getCalendarById('__ID__')

  evts = cal.getEventsForDay(date)
  if evts.length > 0
    frmdaystr = date.getYear() + '-' +  date.getMonth() + '-' + date.getDate()
    evtday = evts[evts.length - 1].getAllDayStartDate()
    evtdaystr = evtday.getYear() + '-' +  evtday.getMonth() + '-' + evtday.getDate()

    if frmdaystr is evtdaystr
      return '申し訳ありません。その日は既に予約済みです。'

  cal.createAllDayEvent name, date,
    description: "#{name} (#{mail})"
    guests: mail

  result = date.getYear() + "年" + (date.getMonth() + 1) + "月" + date.getDate() + '日に予約しました。（ブラウザーをリロードすると、カレンダーが更新されます）'

  return result
