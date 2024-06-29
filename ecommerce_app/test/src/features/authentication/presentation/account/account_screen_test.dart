import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';
import '../../auth_robot.dart';

void main() {
  testWidgets('account screen ...', (tester) async {
    final r = AuthRobot(tester);

    // pump
    await r.pumpAccountScreen();

    // find logout button and tap it
    await r.tapLogoutButton();

    // expect that the logout dialog is presented
    r.expectLogoutDialogFound();

    // find cancel button and tap it
    await r.tapCancelButton();

    // expect that the logout dialog is no longer visible
    r.expectLogoutDialogNotFound();
  });

  testWidgets('confirm logout, success', (tester) async {
    final r = AuthRobot(tester);

    // pump
    await r.pumpAccountScreen();

    // find logout button and tap it
    await r.tapLogoutButton();

    // expect that the logout dialog is presented
    r.expectLogoutDialogFound();

    // tap logout button
    await r.tapDialogLogoutButton();

    // expect that the logout dialog is no longer visible
    r.expectLogoutDialogNotFound();

    r.expectErrorAlertNotFound();
  });

  testWidgets('confirm logout, failure', (tester) async {
    final r = AuthRobot(tester);

    //
    final authRepo = MockAuthRepository();

    //
    final exception = Exception('Connection Failed');
    when(authRepo.signOut).thenThrow(exception);

    //
    when(authRepo.authStateChanges).thenAnswer((_) =>
        Stream.value(const AppUser(uid: '1234', email: 'daffas@gmail.com')));

    // pump
    await r.pumpAccountScreen(authRepo: authRepo);

    // find logout button and tap it
    await r.tapLogoutButton();

    // expect that the logout dialog is presented
    r.expectLogoutDialogFound();

    // tap logout button
    await r.tapDialogLogoutButton();

    //
    r.expectErrorAlertFound();
  });

  testWidgets('confirm logout, loading state', (tester) async {
    final r = AuthRobot(tester);

    //
    final authRepo = MockAuthRepository();

    //
    when(authRepo.signOut).thenAnswer((_) => Future.delayed(const Duration(seconds: 1)));

    //
    when(authRepo.authStateChanges).thenAnswer((_) =>
        Stream.value(const AppUser(uid: '1234', email: 'daffas@gmail.com')));



    /// when Future.delayed is used, run rest code in runAsync
    await tester.runAsync(() async {

      // pump
      await r.pumpAccountScreen(authRepo: authRepo);

      // find logout button and tap it
      await r.tapLogoutButton();

      // expect that the logout dialog is presented
      r.expectLogoutDialogFound();

      // tap logout button
      await r.tapDialogLogoutButton();

    });

    r.expectCircularProgressIndicatorFound();

  });

}
