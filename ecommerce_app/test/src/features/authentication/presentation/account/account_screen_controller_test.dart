import 'package:ecommerce_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks.dart';


void main() {
  late MockAuthRepository authRepo;
  late AccountScreenController controller;

  setUp((){
    authRepo = MockAuthRepository();
    controller = AccountScreenController(authRepository: authRepo);
  });

  group(
    'AccountScreenController',
    () {
      test(
        'initial state is AsyncValue.data',
        () async {
          // final authRepo = MockAuthRepository();
          // final controller = AccountScreenController(authRepository: authRepo);

          verifyNever(authRepo.signOut);
          expect(controller.state, const AsyncValue<void>.data(null));
        },
      );

      test('signOut success', () async {
        /// 1.setup
        // final authRepo = MockAuthRepository();

        // stub
        when(authRepo.signOut).thenAnswer(
          (_) => Future.value(),
        );

        // final controller = AccountScreenController(authRepository: authRepo);

        // expect(controller.state, const AsyncData<void>(null));

        // use `expectLater` to wait for the future to complete
        expectLater(
            controller.stream,
            emitsInOrder(
                [const AsyncLoading<void>(), const AsyncData<void>(null)]));

        /// 2.run
        await controller.signOut();

        /// 3.verify
        verify(authRepo.signOut).called(1);
      }, timeout: const Timeout(Duration(milliseconds: 500)));

      test(
        'signOut failure',
        () async {
          /// setup
          // final authRepo = MockAuthRepository();
          final exception = Exception('signOut failed');
          when(authRepo.signOut).thenThrow(exception);

          // final controller = AccountScreenController(authRepository: authRepo);

          expectLater(
              controller.stream,
              emitsInOrder([
                const AsyncLoading<void>(),

                //
                predicate<AsyncValue<void>>((value) {
                  expect(value.hasError, true);
                  return true;
                })
              ]));

          /// run
          await controller.signOut();

          /// verify
          verify(authRepo.signOut).called(1);

          // expect(controller.state, AsyncError<void>(exception, StackTrace.current));

          // expect(controller.state.hasError, true);
          // expect(controller.state, isA<AsyncError>());
        },
        timeout: const Timeout(Duration(milliseconds: 500)),
      );
    },
  );
} 
