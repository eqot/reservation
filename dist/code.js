var addEvent, checkData, doGet, removeEvent, time, version;

version = '0.1.0';

time = 'Tue Jul 29 2014 02:52:03 GMT+0900 (JST)';

doGet = function(e) {
  return HtmlService.createHtmlOutputFromFile('index');
};

checkData = function(form) {
  if (form.cmd === 'delete') {
    return removeEvent(form);
  } else {
    return addEvent(form);
  }
};

addEvent = function(form) {
  var cal, event, events, mail, name, resource, time_e, time_s, _i, _len;
  name = form.name;
  mail = form.mail;
  time_s = new Date(form.time_s);
  time_e = new Date(form.time_e);
  resource = form.resource;
  cal = CalendarApp.getCalendarById('__ID__');
  events = cal.getEvents(time_s, time_e);
  for (_i = 0, _len = events.length; _i < _len; _i++) {
    event = events[_i];
    if (event.getTitle() === resource) {
      return '先約があるため、予約できませんでした。';
    }
  }
  cal.createEvent(resource, time_s, time_e, {
    description: "" + name + " (" + mail + ")",
    guests: mail
  });
  return '予約しました。(ブラウザーをリロードすると、カレンダーが更新されます)';
};

removeEvent = function(form) {
  var cal, event, events, mail, name, resource, time_e, time_s, _i, _len;
  name = form.name;
  mail = form.mail;
  time_s = new Date(form.time_s);
  time_e = new Date(form.time_e);
  resource = form.resource;
  cal = CalendarApp.getCalendarById('__ID__');
  events = cal.getEvents(time_s, time_e);
  for (_i = 0, _len = events.length; _i < _len; _i++) {
    event = events[_i];
    if (event.getTitle() === resource && event.getDescription() === ("" + name + " (" + mail + ")")) {
      event.deleteEvent();
      return '削除しました。(ブラウザーをリロードすると、カレンダーが更新されます)';
    }
  }
  return '該当する予約がなかったため、削除できませんでした。';
};
