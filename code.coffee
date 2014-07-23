doGet = (e) ->
  return HtmlService.createHtmlOutputFromFile 'index'

checkData = (frm) ->
  mail = frm['mail']
  user1 = frm['user']
  date1 = new Date(frm['date'])

  Logger.log(date1)

  cal = CalendarApp.getCalendarById('__ID__')
  result = ''
  evts = cal.getEventsForDay(date1)

  if evts.length > 0
    frmdaystr = date1.getYear() + '-' +  date1.getMonth() + '-' + date1.getDate()
    evtday = evts[evts.length - 1].getAllDayStartDate()
    evtdaystr = evtday.getYear() + '-' +  evtday.getMonth() + '-' + evtday.getDate()

    Logger.log(evts.length)
    Logger.log(frmdaystr)
    Logger.log(evtdaystr)

    if frmdaystr is evtdaystr
      result = '申し訳ありません。その日は既に予約済みです。'
    else
      cal.createAllDayEvent('予約済', date1, {description:user1 + '様。連絡先：' + mail, guests:mail})
      result = date1.getYear() + "年" + (date1.getMonth() + 1) + "月" + date1.getDate() + '日に予約しました。（ブラウザーをリロードすると、カレンダーが更新されます）'
  else
    cal.createAllDayEvent('予約済', date1, {description:user1 + '様。連絡先：' + mail, guests:mail})
    result = date1.getYear() + "年" + (date1.getMonth() + 1) + "月" + date1.getDate() + '日に予約しました。（ブラウザーをリロードすると、カレンダーが更新されます）'

  return result
