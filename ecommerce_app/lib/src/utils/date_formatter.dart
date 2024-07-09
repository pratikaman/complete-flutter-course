import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_formatter.g.dart';

// final dateFormatterProvider = Provider<DateFormat>((ref) {
//   /// Date formatter to be used in the app.
//   return DateFormat.MMMEd();
// });


@riverpod
DateFormat dateFormatter(DateFormatterRef ref){
  return DateFormat.MMMEd();
}
