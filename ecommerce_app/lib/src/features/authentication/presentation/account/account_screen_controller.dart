import 'dart:async';

import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_screen_controller.g.dart';


// class AccountScreenController extends StateNotifier<AsyncValue<void>> {
//   AccountScreenController({required this.authRepository})
//       : super(const AsyncData(null));
//   final FakeAuthRepository authRepository;

//   Future<void> signOut() async {
//     state = const AsyncLoading();
//     state = await AsyncValue.guard(() => authRepository.signOut());
//   }
// }

// final accountScreenControllerProvider = StateNotifierProvider.autoDispose<
//     AccountScreenController, AsyncValue<void>>((ref) {
//   final authRepository = ref.watch(authRepositoryProvider);
//   return AccountScreenController(
//     authRepository: authRepository,
//   );
// });




// class AccountScreenController extends AutoDisposeAsyncNotifier<void> {
//   @override
//   FutureOr<void> build() {
//     /// noithing
//   }

//   Future<void> signOut() async {
//     final authRepository = ref.read(authRepositoryProvider);
//     state = const AsyncLoading();
//     state = await AsyncValue.guard(() => authRepository.signOut());
//   }
// }

// final accountScreenControllerProvider =
//     AsyncNotifierProvider.autoDispose<AccountScreenController, void>(AccountScreenController.new);






@riverpod
class AccountScreenController extends _$AccountScreenController {
  @override
  FutureOr<void> build() {
    /// 
  }

    Future<void> signOut() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signOut());
  }

}