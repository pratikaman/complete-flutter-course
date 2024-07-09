import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_date_provider.g.dart';



/// A provider that returns a function that returns the current date.
/// This makes it easy to mock the current date in tests.
// final currentDateBuilderProvider = Provider<DateTime Function()>((ref) {
//   return () => DateTime.now();
// });

@riverpod
DateTime Function() currentDateBuilder(CurrentDateBuilderRef ref) {
  return () => DateTime.now();
}
