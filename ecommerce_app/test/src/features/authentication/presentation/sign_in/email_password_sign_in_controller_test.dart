import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_controller.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';



void main() {
  const testEmail = 'pratik@gmail.com';
  const testPassword = 'dwaef';

  group('submit', () {
    test(
      '''
  Given formType is signIn
  When signInWithEmailAndPassword succeeds
  Then return true
  And state.value is AsyncData
  ''',
      () async {
        final authRepo = MockAuthRepository();

        when(() => authRepo.signInWithEmailAndPassword(testEmail, testPassword))
            .thenAnswer((_) => Future.value());

        final controller = EmailPasswordSignInController(
          authRepository: authRepo,
          formType: EmailPasswordSignInFormType.signIn,
        );

        expectLater(
            controller.stream,
            emitsInOrder([
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.signIn,
                value: const AsyncLoading<void>(),
              ),
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.signIn,
                value: const AsyncData<void>(null),
              )
            ]));

        final result = await controller.submit(testEmail, testPassword);

        expect(result, true);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );

    test(
      '''
  Given formType is signIn
  When signInWithEmailAndPassword failed
  Then return false
  And state.value is AsyncError
  ''',
      () async {
        final authRepo = MockAuthRepository();

        final exception = Exception('connection failed');

        when(() => authRepo.signInWithEmailAndPassword(testEmail, testPassword))
            .thenThrow(exception);

        final controller = EmailPasswordSignInController(
          authRepository: authRepo,
          formType: EmailPasswordSignInFormType.signIn,
        );

        expectLater(
          controller.stream,
          emitsInOrder(
            [
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.signIn,
                value: const AsyncLoading<void>(),
              ),

              /// this will create issue.
              // EmailPasswordSignInState(
              //   formType: EmailPasswordSignInFormType.signIn,
              //   value: const AsyncError(),
              // )

              /// use predicate
              predicate<EmailPasswordSignInState>((state) {
                expect(state.formType, EmailPasswordSignInFormType.signIn);
                expect(state.value.hasError, true);
                return true;
              }),
            ],
          ),
        );

        final result = await controller.submit(testEmail, testPassword);

        expect(result, false);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );

    test(
      '''
  Given formType is register
  When createUserWithEmailAndPassword succeeds
  Then return true
  And state.value is AsyncData
  ''',
      () async {
        final authRepo = MockAuthRepository();

        when(() => authRepo.createUserWithEmailAndPassword(
            testEmail, testPassword)).thenAnswer((_) => Future.value());

        final controller = EmailPasswordSignInController(
          authRepository: authRepo,
          formType: EmailPasswordSignInFormType.register,
        );

        expectLater(
            controller.stream,
            emitsInOrder([
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.register,
                value: const AsyncLoading<void>(),
              ),
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.register,
                value: const AsyncData<void>(null),
              )
            ]));

        final result = await controller.submit(testEmail, testPassword);

        expect(result, true);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );

    test(
      '''
  Given formType is register
  When createUserWithEmailAndPassword failed
  Then return false
  And state.value is AsyncError
  ''',
      () async {
        final authRepo = MockAuthRepository();
        final exception = Exception('connection failed');

        when(() => authRepo.createUserWithEmailAndPassword(
            testEmail, testPassword)).thenThrow(exception);

        final controller = EmailPasswordSignInController(
          authRepository: authRepo,
          formType: EmailPasswordSignInFormType.register,
        );

        expectLater(
          controller.stream,
          emitsInOrder(
            [
              EmailPasswordSignInState(
                formType: EmailPasswordSignInFormType.register,
                value: const AsyncLoading<void>(),
              ),

              /// this will create issue.
              // EmailPasswordSignInState(
              //   formType: EmailPasswordSignInFormType.register,
              //   value: const AsyncData<void>(null),
              // )

              /// use predicate
              predicate<EmailPasswordSignInState>((state) {
                expect(state.formType, EmailPasswordSignInFormType.register);
                expect(state.value.hasError, true);
                return true;
              }),
            ],
          ),
        );

        final result = await controller.submit(testEmail, testPassword);

        expect(result, false);
      },
      timeout: const Timeout(Duration(milliseconds: 500)),
    );
  });

  group(
    'update form type',
    () {
      test(
        '''
  Given formType is signIn
  When called with register
  Then state.formtype is register
  ''',
        () {
          final authRepo = MockAuthRepository();

          final controller = EmailPasswordSignInController(
            authRepository: authRepo,
            formType: EmailPasswordSignInFormType.signIn,
          );

          controller.updateFormType(EmailPasswordSignInFormType.register);

          expect(
            controller.state,
            EmailPasswordSignInState(
              formType: EmailPasswordSignInFormType.register,
              value: const AsyncData<void>(null),
            ),
          );
        },
      );

      test(
        '''
  Given formType is register
  When called with register
  Then state.formtype is signIn
  ''',
        () {
          final authRepo = MockAuthRepository();

          final controller = EmailPasswordSignInController(
            authRepository: authRepo,
            formType: EmailPasswordSignInFormType.register,
          );

          controller.updateFormType(EmailPasswordSignInFormType.signIn);

          expect(
            controller.state,
            EmailPasswordSignInState(
              formType: EmailPasswordSignInFormType.signIn,
              value: const AsyncData<void>(null),
            ),
          );
        },
      );
    },
  );
}
