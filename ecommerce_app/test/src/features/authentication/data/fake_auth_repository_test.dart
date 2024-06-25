import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FakeAuthRepository makeAuthRepo() => FakeAuthRepository(addDelay: false);

  const testEmail = 'test@test.com';
  const testPassword = '1234';
  final testUser = AppUser(
    uid: testEmail.split('').reversed.join(),
    email: testEmail,
  );

  group('FakeAuthRepository', () {
    test('currentUser', () {
      final authRepo = makeAuthRepo();
      // register this upfront - will be called even if the test throw an exception later
      addTearDown(authRepo.dispose);
      expect(authRepo.currentUser, null);
      expect(authRepo.authStateChanges(), emits(null));
    });

    test('currentUser is not null after sign in', () async {
      final authRepository = makeAuthRepo();
      // register this upfront - will be called even if the test throw an exception later
      addTearDown(authRepository.dispose);
      await authRepository.signInWithEmailAndPassword(
        testEmail,
        testPassword,
      );
      expect(authRepository.currentUser, testUser);
      expect(authRepository.authStateChanges(), emits(testUser));
    });

    test('currentUser is not null after create', () async {
      final authRepository = makeAuthRepo();
      // register this upfront - will be called even if the test throw an exception later
      addTearDown(authRepository.dispose);
      await authRepository.createUserWithEmailAndPassword(
        testEmail,
        testPassword,
      );
      expect(authRepository.currentUser, testUser);
      expect(authRepository.authStateChanges(), emits(testUser));
    });

    test('currentUser is not null after sign out', () async {
      final authRepository = makeAuthRepo();
      // register this upfront - will be called even if the test throw an exception later
      addTearDown(authRepository.dispose);
      await authRepository.signInWithEmailAndPassword(
        testEmail,
        testPassword,
      );
      expect(authRepository.currentUser, testUser);
      expect(authRepository.authStateChanges(), emits(testUser));

      // expect(
      //     authRepository.authStateChanges(),
      //     emitsInOrder([
      //       testUser,
      //       null,
      //     ]));

      await authRepository.signOut();
      expect(authRepository.currentUser, null);
      expect(authRepository.authStateChanges(), emits(null));
    });

    test('sign in after dispose throws exception', () {
      final authRepository = makeAuthRepo();
      // register this upfront - will be called even if the test throw an exception later
      addTearDown(authRepository.dispose);
      authRepository.dispose();

      expect(
          () => authRepository.signInWithEmailAndPassword(
                testEmail,
                testPassword,
              ),
          throwsStateError);
    });

    
  });
}
