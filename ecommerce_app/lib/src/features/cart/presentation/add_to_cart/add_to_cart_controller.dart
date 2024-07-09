import 'dart:async';

import 'package:ecommerce_app/src/features/cart/application/cart_service.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_to_cart_controller.g.dart';

// class AddToCartController extends StateNotifier<AsyncValue<int>> {
//   AddToCartController({required this.cartService}) : super(const AsyncData(1));
//   final CartService cartService;

//   void updateQuantity(int quantity) {
//     state = AsyncData(quantity);
//   }

//   Future<void> addItem(ProductID productId) async {
//     final item = Item(productId: productId, quantity: state.value!);
//     state = const AsyncLoading<int>().copyWithPrevious(state);
//     final value = await AsyncValue.guard(() => cartService.addItem(item));
//     if (value.hasError) {
//       state = AsyncError(value.error!, StackTrace.current);
//     } else {
//       state = const AsyncData(1);
//     }
//   }
// }

// final addToCartControllerProvider =
//     StateNotifierProvider.autoDispose<AddToCartController, AsyncValue<int>>(
//         (ref) {
//   return AddToCartController(
//     cartService: ref.watch(cartServiceProvider),
//   );
// });


@riverpod
class AddToCartController extends _$AddToCartController {

  @override
  FutureOr<int> build() {
    return 1;
  }
 

  void updateQuantity(int quantity) {
    state = AsyncData(quantity);
  }

  Future<void> addItem(ProductID productId) async {
    final cartService = ref.read(cartServiceProvider);
    final item = Item(productId: productId, quantity: state.value!);
    state = const AsyncLoading<int>().copyWithPrevious(state);
    final value = await AsyncValue.guard(() => cartService.addItem(item));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = const AsyncData(1);
    }
  }
}