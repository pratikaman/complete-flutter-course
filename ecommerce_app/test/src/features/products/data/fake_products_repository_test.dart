import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

/// this is a unit test for the FakeProductsRepository class
void main() {

  FakeProductsRepository makeProductRepo () => FakeProductsRepository(addDelay: false);

  group("FakeProductRepository", () {
    test('getProductsList returns global list', () {
      final productsRepository = makeProductRepo();
      expect(
        productsRepository.getProductsList(),
        kTestProducts,
      );
    });

    test('getProduct(1) return first object', () {
      final productsRepository = makeProductRepo();
      expect(
        productsRepository.getProduct('1'),
        kTestProducts[0],
      );
    });

    test('getProduct(100) return null', () {
      final productsRepository = makeProductRepo();
      expect(
        productsRepository.getProduct('100'),
        null,
      );
    });

    test("fetchProductList return global list", () async {
      final productsRepository = makeProductRepo();
      expect(
        await productsRepository.fetchProductsList(),
        kTestProducts,
      );
    });

    test("watchProductList emits global list", () {
      final productsRepository = makeProductRepo();
      expect(
        productsRepository.watchProductsList(),
        emits(kTestProducts),
      );
    });

    test("watchProduct(1) emits first object", () {
      final productsRepository = makeProductRepo();
      expect(
        productsRepository.watchProduct('1'),
        emits(kTestProducts[0]),
      );
    });

    test("watchProduct(100) emits null", () {
      final productsRepository = makeProductRepo();
      expect(
        productsRepository.watchProduct('100'),
        emits(null),
      );
    });
  });
}
