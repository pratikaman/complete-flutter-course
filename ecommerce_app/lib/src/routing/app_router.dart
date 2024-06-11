import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/account/account_screen.dart';
import 'package:ecommerce_app/src/features/checkout/checkout_screen.dart';
import 'package:ecommerce_app/src/features/leave_review_page/leave_review_screen.dart';
import 'package:ecommerce_app/src/features/not_found/not_found_screen.dart';
import 'package:ecommerce_app/src/features/orders_list/orders_list_screen.dart';
import 'package:ecommerce_app/src/features/product_page/product_screen.dart';
import 'package:ecommerce_app/src/features/products_list/products_list_screen.dart';
import 'package:ecommerce_app/src/features/shopping_cart/shopping_cart_screen.dart';
import 'package:ecommerce_app/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/sign_in/email_password_sign_in_state.dart';

enum AppRoute {
  home,
  cart,
  orders,
  account,
  signIn,
  product,
  leaveReview,
  checkout,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  errorBuilder: (context, state) => const NotFoundScreen(),
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      builder: (context, state) => const ProductsListScreen(),
      routes: [
        GoRoute(
          path: 'cart',
          name: AppRoute.cart.name,

          /// use this for default transition.
          // builder: (context, state) => const ShoppingCartScreen(),

          /// use this for customisation.
          pageBuilder: (context, state) {
            return MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const ShoppingCartScreen(),
            );
          },
          routes: [
            GoRoute(
                path: 'checkout',
                name: AppRoute.checkout.name,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: const CheckoutScreen(),
                  );
                }),
          ],
        ),
        GoRoute(
          path: 'account',
          name: AppRoute.account.name,
          builder: (context, state) => const OrdersListScreen(),
        ),
        GoRoute(
          path: 'orders',
          name: AppRoute.orders.name,
          builder: (context, state) => const AccountScreen(),
        ),
        GoRoute(
            path: 'signIn',
            name: AppRoute.signIn.name,
            pageBuilder: (context, state) {
              return MaterialPage(
                key: state.pageKey,
                fullscreenDialog: true,
                child: const EmailPasswordSignInScreen(
                    formType: EmailPasswordSignInFormType.signIn),
              );
            }),
        GoRoute(
          path: 'product/:id',
          name: AppRoute.product.name,
          builder: (context, state) {
            //
            final productId = state.pathParameters['id']!;
            //
            return ProductScreen(productId: productId);
          },
          routes: [
            GoRoute(
                path: 'review',
                name: AppRoute.leaveReview.name,
                pageBuilder: (context, state) {
                  final productId = state.pathParameters['id']!;

                  return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: LeaveReviewScreen(
                      productId: productId,
                    ),
                  );
                }),
          ],
        ),
      ],
    ),
  ],
);
