import 'package:ecommerce_app/src/features/cart/application/cart_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../products/domain/product.dart';
import '../../domain/item.dart';

class AddToCartController extends StateNotifier<AsyncValue<int>> {
  AddToCartController({required this.cartService})
      : super(const AsyncValue.data(1));

  final CartService cartService;


  void updateQuantity(int quantity) {
    state = AsyncValue.data(quantity);
  }

  Future<void> addItem(ProductID productId) async {
    final item = Item(productId: productId, quantity: state.value!);
    //
    state = const AsyncLoading<int>().copyWithPrevious(state);

    final value  = await AsyncValue.guard(() => cartService.addItem(item));

    if (value.hasError) {
      state = AsyncValue.error(value.error!, StackTrace.current);
    }
    else {
      state = const AsyncValue.data(1);
    }

  }

}

final addToCartControllerProvider =
    StateNotifierProvider.autoDispose<AddToCartController, AsyncValue<int>>((ref) {
  return AddToCartController(
    cartService: ref.watch(cartServiceProvider),
  );
});
