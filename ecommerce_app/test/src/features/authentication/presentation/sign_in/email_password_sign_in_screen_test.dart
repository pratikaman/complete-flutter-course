import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  const testEmail = "test@gmail.com";
  const testPassword = "24321";

  late MockAuthRepository authRepo;

  setUp(() {
    authRepo = MockAuthRepository();
  });

  group('sign in', () {
    testWidgets('''
        Given formType is signIn
        When tap on the sign-in button
        Then signInWithEmailAndPassword is not called
        ''', (tester) async {
      final r = AuthRobot(tester);

      await r.pumpEmailPasswordSignInContents(
        formType: EmailPasswordSignInFormType.signIn,
        authRepo: authRepo,
      );

      await r.tapEmailAndPasswordSubmitButton();

      verifyNever(() => authRepo.signInWithEmailAndPassword(
            any(),
            any(),
          ));
    });

    testWidgets('''
        Given formType is signIn
        When enter valid email and password
        And tap on the sign-in button
        Then signInWithEmailAndPassword is called
        And onSignedIn callback is called
        And error alert is not shown
     ''', (tester) async {
      bool didSignIn = false;

      final r = AuthRobot(tester);

      when(() => authRepo.signInWithEmailAndPassword(testEmail, testPassword))
          .thenAnswer((_) => Future.value());

      await r.pumpEmailPasswordSignInContents(
        formType: EmailPasswordSignInFormType.signIn,
        authRepo: authRepo,
        onSignedIn: () => didSignIn = true,
      );

      await r.enterEmail(testEmail);
      await r.enterPassword(testPassword);
      await r.tapEmailAndPasswordSubmitButton();

      verify(() => authRepo.signInWithEmailAndPassword(testEmail, testPassword))
          .called(1);

      r.expectErrorAlertNotFound();

      expect(didSignIn, true);
    });
  });
}
