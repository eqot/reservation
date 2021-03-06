IDS = ['date', 'time_s', 'time_e', 'resource', 'name', 'mail']

doAction = (event) ->
  params = getParams()

  if params.isFilled
    google.script.run.withSuccessHandler(onSuccess).withFailureHandler(onFailure).checkData(params)

    document.querySelector('#msg').textContent = '……処理中……'

doDelete = (event) ->
  params = getParams()
  params.cmd = 'delete'

  # for key of params
  #   console.log "#{key}, #{params[key]}"

  if params.isFilled and confirm '本当に削除してもよろしいですか?'
    google.script.run.withSuccessHandler(onSuccess).withFailureHandler(onFailure).checkData(params)

    document.querySelector('#msg').textContent = '……処理中……'

onSuccess = (result) ->
  document.querySelector('#msg').textContent = result

onFailure = (error) ->
  alert(error.message)
  document.querySelector('#msg').textContent = ''

getParams = ->
  isFilled = true

  params = {}
  for id in IDS
    params[id] = document.querySelector('#' + id).value

    if params[id].length is 0
      isFilled = false

  time_s = new Date params.date
  time_s.setHours params.time_s.substr 0, 2
  time_s.setMinutes params.time_s.substr 3, 2
  time_e = new Date params.date
  time_e.setHours params.time_e.substr 0, 2
  time_e.setMinutes params.time_e.substr 3, 2

  params.time_s = time_s.toString()
  params.time_e = time_e.toString()

  resources = document.querySelector '#resource'
  index = resources.selectedIndex
  params.resource = resources.options[index].text

  params.isFilled = isFilled

  return params

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

  # document.querySelector('#name').value = 'Just Test'
  # document.querySelector('#mail').value = 'foo@bar.com'

  timelist = document.querySelector '#timelist'
  for hour in [7..23]
    time = document.createElement 'option'
    time.value = fillZero(hour) + ':00'
    timelist.appendChild time

fillZero = (value) ->
  return if value < 10 then '0' + value else value


initialize();
