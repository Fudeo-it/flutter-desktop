import 'dart:async';

import 'package:data_fixture_dart/data_fixture_dart.dart';
import 'package:products_app/models/product.dart';
import 'package:products_app/services/products_service.dart';

class MemoryProductsService extends ProductsService {
  final List<Product> _products = [...ProductFixture.factory().makeMany(30)];

  @override
  Future<List<Product>> get products async => _products;

  @override
  Future<Product> save(Product product) async {
    _products.add(product);

    return product;
  }
}

extension ProductFixture on Product {
  static ProductFixtureFactory factory() => ProductFixtureFactory();
}

class ProductFixtureFactory extends FixtureFactory<Product> {
  @override
  FixtureDefinition<Product> definition() => define(
        (faker) => Product(
          id: faker.randomGenerator.integer(100),
          name: faker.food.dish(),
          description: faker.food.cuisine(),
          category: faker.food.restaurant(),
          quantity: faker.randomGenerator.integer(10),
        ),
      );
}
