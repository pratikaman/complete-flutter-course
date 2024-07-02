// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/local/local_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/data/remote/remote_cart_repository.dart';
import 'package:ecommerce_app/src/features/cart/domain/cart.dart';
import 'package:ecommerce_app/src/features/cart/domain/item.dart';
import 'package:ecommerce_app/src/features/cart/domain/mutable_cart.dart';
import 'package:ecommerce_app/src/features/products/domain/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartService {
  final FakeAuthRepository authRepository;
  final LocalCartRepository localCartRepository;
  final RemoteCartRepository remoteCartRepository;

  CartService({
    required this.authRepository,
    required this.localCartRepository,
    required this.remoteCartRepository,
  });

  /// fetch the cart from the local or remote repository
  /// depending on the user auth state
  Future<Cart> _fetchCart() {
    final user = authRepository.currentUser;

    if (user != null) {
      return remoteCartRepository.fetchCart(user.uid);
    } else {
      return localCartRepository.fetchCart();
    }
  }

  /// save the cart to the local or remote repository
  /// depending on the user auth state
  Future<void> _setCart(Cart cart) async {
    final user = authRepository.currentUser;

    if (user != null) {
      await remoteCartRepository.setCart(user.uid, cart);
    } else {
      await localCartRepository.setCart(cart);
    }

  }

  /// sets an item in the local or remote cart depending on the user auth state
  Future<void> setItem(Item item) async {
    final cart = await _fetchCart();
    final updatedCart = cart.setItem(item);
    await _setCart(updatedCart);
  }

  /// adds an item in the local or remote cart depending on the user auth state
  Future<void> addItem(Item item) async {
    final cart = await _fetchCart();
    final updatedCart = cart.addItem(item);
    await _setCart(updatedCart);
  }

  /// removes an item from the local or remote cart depending on the user auth
  /// state
  Future<void> removeItemById(ProductID id) async {
    final cart = await _fetchCart();
    final updatedCart = cart.removeItemById(id);
    await _setCart(updatedCart);
  }


}

final cartServiceProvider = Provider<CartService>((ref) {
  
  final authRepo = ref.watch(authRepositoryProvider);
  final localCartRepo = ref.watch(localCartRepositoryProvider);
  final remoteCartRepo = ref.watch(remoteCartRepositoryProvider);


  return CartService(
    authRepository: authRepo,
    localCartRepository: localCartRepo,
    remoteCartRepository: remoteCartRepo,
  );

});
