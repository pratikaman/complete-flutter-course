import 'package:ecommerce_app/src/common_widgets/alert_dialogs.dart';
import 'package:ecommerce_app/src/common_widgets/primary_button.dart';
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_screen.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:ecommerce_app/src/features/products/presentation/home_app_bar/more_menu_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class AuthRobot {
  final WidgetTester tester;

  AuthRobot(this.tester);


  Future<void> openEmailPasswordSignInScreen() async{
    final finder = find.byKey(MoreMenuButton.signInKey);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> pumpEmailPasswordSignInContents({
    VoidCallback? onSignedIn,
    required EmailPasswordSignInFormType formType,
    required FakeAuthRepository authRepo,
  }) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authRepositoryProvider.overrideWithValue(authRepo),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: EmailPasswordSignInContents(
              formType: formType,
              onSignedIn: onSignedIn,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> tapEmailAndPasswordSubmitButton() async {
    final submitButton = find.byType(PrimaryButton);

    expect(submitButton, findsOneWidget);

    await tester.tap(submitButton);

    await tester.pumpAndSettle();
  }

  Future<void> enterEmail(String email) async {
    final emailField = find.byKey(EmailPasswordSignInScreen.emailKey);

    expect(emailField, findsOneWidget);

    await tester.enterText(emailField, email);
  }

  Future<void> enterPassword(String password) async {
    final passwordEmailField = find.byKey(EmailPasswordSignInScreen.passwordKey);

    expect(passwordEmailField, findsOneWidget);

    await tester.enterText(passwordEmailField, password);
  }

  Future<void> signInWithEmailAndPassword() async {
    await enterEmail('test@test.com');
    await enterPassword('feaf');
    await tapEmailAndPasswordSubmitButton();
  }

  Future<void> openAccountScreen() async {
    final finder = find.byKey(MoreMenuButton.accountKey);
    expect(finder, findsOneWidget);
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }


  //////////////////////////////////////////////////////////////////////
  Future<void> pumpAccountScreen({FakeAuthRepository? authRepo}) async {
    await tester.pumpWidget(
      ProviderScope(
        ///
        overrides: [
          if (authRepo != null)
            authRepositoryProvider.overrideWithValue(authRepo)
        ],

        child: const MaterialApp(
          home: AccountScreen(),
        ),
      ),
    );
  }

  Future<void> tapLogoutButton() async {
    final logoutButton = find.text('Logout');

    expect(logoutButton, findsOneWidget);

    await tester.tap(logoutButton);

    await tester.pump();
  }

  void expectLogoutDialogFound() {
    final dialogTitle = find.text('Are you sure?');

    expect(dialogTitle, findsOneWidget);
  }

  Future<void> tapCancelButton() async {
    final cancelButton = find.text('Cancel');

    expect(cancelButton, findsOneWidget);

    await tester.tap(cancelButton);

    await tester.pump();
  }

  void expectLogoutDialogNotFound() {
    final dialogTitle = find.text('Are you sure?');

    expect(dialogTitle, findsNothing);
  }

  Future<void> tapDialogLogoutButton() async {
    final logoutButton = find.byKey(kDialogDefaultKey);

    expect(logoutButton, findsOneWidget);

    await tester.tap(logoutButton);

    await tester.pump();
  }

  void expectErrorAlertFound() {
    final finder = find.text("Error");
    expect(finder, findsOneWidget);
  }

  void expectErrorAlertNotFound() {
    final finder = find.text("Error");
    expect(finder, findsNothing);
  }

  void expectCircularProgressIndicatorFound() {
    final finder = find.byType(CircularProgressIndicator);
    expect(finder, findsOneWidget);
  }
}
