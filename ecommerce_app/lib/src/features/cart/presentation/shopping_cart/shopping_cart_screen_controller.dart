import 'package:ecommerce_app/src/features/cart/application/cart_service.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingCartScreenController extends StateNotifier<AsyncValue<void>> {
  ShoppingCartScreenController({required this.cartService}) : super(const AsyncValue.data(null));

  final CartService cartService;

  Future<void> updateItemQuantity(ProductID productId, int quantity) async {
    final updatedItem = Item(productId: productId, quantity: quantity);
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => cartService.setItem(updatedItem));
  }

  Future<void> removeItemById(ProductID productId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => cartService.removeItemById(productId));
  }

}

final shoppingCartScreenControllerProvider = StateNotifierProvider<ShoppingCartScreenController, AsyncValue<void>>((ref) {
  final cartService = ref.watch(cartServiceProvider);
  return ShoppingCartScreenController(cartService: cartService);
});
