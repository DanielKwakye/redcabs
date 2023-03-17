// Override "en" locale messages with custom messages that are more precise and short
import 'package:timeago/timeago.dart';


// my_custom_messages.dart
class TimeagoMessages implements LookupMessages {
  @override String prefixAgo() => '';
  @override String prefixFromNow() => '';
  @override String suffixAgo() => '';
  @override String suffixFromNow() => '';
  @override String lessThanOneMinute(int seconds) => 'now';
  @override String aboutAMinute(int minutes) => minutes > 59 ? '1h' : '${minutes}m';
  @override String minutes(int minutes) =>  minutes > 59 ? '1h' : '${minutes}m';
  @override String aboutAnHour(int minutes) =>  minutes > 59 ? '1h' : '${minutes}m';
  @override String hours(int hours) => hours > 24 ? '1d' : '${hours}h';
  @override String aDay(int hours) => '1d';
  @override String days(int days) => '${days}d';
  @override String aboutAMonth(int days) => '1mo';
  @override String months(int months) => '${months}mo';
  @override String aboutAYear(int year) => '${year}y';
  @override String years(int years) => '${years}y';
  @override String wordSeparator() => ' ';
}