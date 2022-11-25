import 'dart:async';

import 'package:products_app/models/product.dart';
import 'package:products_app/services/products_service.dart';

class ProductsRepository {
  final ProductsService productsService;

  ProductsRepository({required this.productsService});

  Future<List<Product>> get products => productsService.products;

  Future<Product> save({
    required int id,
    required String name,
    required String description,
    required String category,
    required int quantity,
  }) async {
    final productToSave = Product(
      id: id,
      name: name,
      description: description,
      category: category,
      quantity: quantity,
    );

    return await productsService.save(productToSave);
  }
}
