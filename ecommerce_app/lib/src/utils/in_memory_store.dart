import 'package:rxdart/rxdart.dart';


/// An in-memory store backed by BehaviourSubject that can be used to
/// store the data for all the fake repositories in the app.
class InMemoryStore<T> {

  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);

  /// The BehaviourSubject that holds the data.
  final BehaviorSubject<T> _subject;

  /// The output stream that can be used to listen to the data.
  Stream<T> get stream => _subject.stream;
  /// A synchronous getter to get the current value of the data.
  T get value => _subject.value;
  /// A setter for updating the value
  set value(T value) => _subject.add(value);
  /// Don't forget to close the subject when it's no longer needed.
  void close() => _subject.close();

}