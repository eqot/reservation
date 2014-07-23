doAction = (event) ->
  param = new Object()
  d = document.querySelector('#date').value
  dstr = new Date(d).toString()

  param['date'] = dstr
  param['user'] = document.querySelector('#user').value
  param['mail'] = document.querySelector('#mail').value

  google.script.run.withSuccessHandler(onSuccess).withFailureHandler(onFailure).checkData(param)

  document.querySelector('#msg').textContent = '……問い合わせ中……'

onSuccess = (result) ->
  document.querySelector('#msg').textContent = result

onFailure = (error) ->
  alert(error.message)
  document.querySelector('#msg').textContent = ''
