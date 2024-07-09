import 'dart:async';

import 'package:ecommerce_app/src/features/checkout/application/fake_checkout_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'payment_button_controller.g.dart';

// class PaymentButtonController extends StateNotifier<AsyncValue<void>> {
//   PaymentButtonController({required this.checkoutService})
//       : super(const AsyncData(null));
//   final FakeCheckoutService checkoutService;

//   Future<void> pay() async {
//     state = const AsyncLoading();
//     final newState = await AsyncValue.guard(checkoutService.placeOrder);
//     // * Check if the controller is mounted before setting the state to prevent:
//     // * Bad state: Tried to use PaymentButtonController after `dispose` was called.
//     if (mounted) {
//       state = newState;
//     }
//   }
// }

// final paymentButtonControllerProvider = StateNotifierProvider.autoDispose<
//     PaymentButtonController, AsyncValue<void>>((ref) {
//   return PaymentButtonController(
//     checkoutService: ref.watch(checkoutServiceProvider),
//   );
// });

@riverpod
class PaymentButtonController extends _$PaymentButtonController {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => mounted = false);
  }

  Future<void> pay() async {
    final checkoutService = ref.read(checkoutServiceProvider);
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(checkoutService.placeOrder);
    // * Check if the controller is mounted before setting the state to prevent:
    // * Bad state: Tried to use PaymentButtonController after `dispose` was called.
    if (mounted) {
      state = newState;
    }
  }
}
