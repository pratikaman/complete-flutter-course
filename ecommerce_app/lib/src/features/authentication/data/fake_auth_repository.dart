import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../../utils/in_memory_store.dart';
import '../domain/app_user.dart';

abstract class AuthRepository {
  Future<void> signInWithEmailAndPassword(String email, String password);

  Future<void> createUserWithEmailAndPassword(String email, String password);

  Future<void> signOut();

  Stream<AppUser?> authStateChanges();

  AppUser? get currentUser;
}

class FakeAuthRepository implements AuthRepository{

  final _authState = InMemoryStore<AppUser?>(null);

  @override
  Stream<AppUser?> authStateChanges() => _authState.stream;

  @override
  AppUser? get currentUser => _authState.value;


  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (currentUser == null){
      _createUser(email);
    }
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    if (currentUser == null){
      _createUser(email);
    }
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(seconds: 2));
    // throw Exception("Sign out failed");
    _authState.value = null;
  }

  void _createUser(String email){
    _authState.value = AppUser(uid: email.split("").reversed.join(), email: email);
  }

  void dispose() => _authState.close();

}


class FirebaseAuthRepository implements AuthRepository {
  @override
  Stream<AppUser?> authStateChanges() {
    // TODO: implement authStateChanges
    throw UnimplementedError();
  }

  @override
  Future<void> createUserWithEmailAndPassword(String email, String password) {
    // TODO: implement createUserWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  // TODO: implement currentUser
  AppUser? get currentUser => throw UnimplementedError();

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) {
    // TODO: implement signInWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
  // TODO: Override methods
}


final authRepositoryProvider = Provider<AuthRepository>((ref){

  // const isFake = String.fromEnvironment('useFakeRepos') == 'true';

  // return isFake ? FakeAuthRepository() : FirebaseAuthRepository();

  return FakeAuthRepository();
});

final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});
