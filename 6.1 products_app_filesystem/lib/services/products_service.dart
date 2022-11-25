import 'dart:async';

import 'package:products_app/models/product.dart';

abstract class ProductsService {
  Future<List<Product>> get products;
  Future<Product> save(Product product);
  FutureOr<bool> delete(int id);
}
