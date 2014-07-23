IDS = ['date', 'time_s', 'time_e', 'name', 'mail']

doAction = (event) ->
  # param = new Object()
  # d = document.querySelector('#date').value
  # dstr = new Date(d).toString()

  # param['date'] = dstr
  # param['user'] = document.querySelector('#user').value
  # param['mail'] = document.querySelector('#mail').value

  isFilled = true

  params = {}
  for id in IDS
    params[id] = document.querySelector('#' + id).value
    console.log "#{id}, #{params[id]}"

    if params[id].length is 0
      isFilled = false

  if isFilled
    google.script.run.withSuccessHandler(onSuccess).withFailureHandler(onFailure).checkData(params)

    document.querySelector('#msg').textContent = '……問い合わせ中……'
  else
    document.querySelector('#msg').textContent = '入力ミス'

onSuccess = (result) ->
  document.querySelector('#msg').textContent = result

onFailure = (error) ->
  alert(error.message)
  document.querySelector('#msg').textContent = ''
