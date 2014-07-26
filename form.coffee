IDS = ['date', 'time_s', 'time_e', 'name', 'mail']

doAction = (event) ->
  isFilled = true

  params = {}
  for id in IDS
    params[id] = document.querySelector('#' + id).value

    if id is 'date'
      params[id] = new Date(params[id]).toString()

    if params[id].length is 0
      isFilled = false

  time_s = new Date params.date
  time_s.setHours params.time_s.substr 0, 2
  time_s.setMinutes params.time_s.substr 3, 2
  time_e = new Date params.date
  time_e.setHours params.time_e.substr 0, 2
  time_e.setMinutes params.time_e.substr 3, 2

  params.time_s = time_s
  params.time_e = time_e

  for key of params
    console.log "#{key}, #{params[key]}"

  if isFilled
    google.script.run.withSuccessHandler(onSuccess).withFailureHandler(onFailure).checkData(params)

    document.querySelector('#msg').textContent = '……問い合わせ中……'

onSuccess = (result) ->
  document.querySelector('#msg').textContent = result

onFailure = (error) ->
  alert(error.message)
  document.querySelector('#msg').textContent = ''

initialize = ->
  date = new Date()
  y = date.getFullYear()
  m = fillZero(date.getMonth() + 1)
  d = date.getDate()
  document.querySelector('#date').value = "#{y}-#{m}-#{d}"

  h = fillZero(date.getHours() + 1)
  m = fillZero 0
  document.querySelector('#time_s').value = "#{h}:#{m}"

  h = fillZero(date.getHours() + 2)
  document.querySelector('#time_e').value = "#{h}:#{m}"

  document.querySelector('#name').value = 'Just Test'
  document.querySelector('#mail').value = 'foo@bar.com'

fillZero = (value) ->
  return if value < 10 then '0' + value else value


initialize();
