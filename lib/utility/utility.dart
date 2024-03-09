import 'package:timeago/timeago.dart' as timeago;


String getHumanReadableDate( int timestamp){
  var locale = 'en';
  DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);

  String message = timeago.format(date, locale: locale, allowFromNow: true);

  return message;

}