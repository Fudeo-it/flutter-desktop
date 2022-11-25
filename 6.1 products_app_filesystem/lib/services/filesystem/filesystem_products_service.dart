import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:products_app/models/product.dart';
import 'package:products_app/services/products_service.dart';

class FilesystemProductsService extends ProductsService {
  File? _instance;

  @override
  FutureOr<bool> delete(int id) async {
    final List<Product> products = List.from(await this.products);
    final index = products.indexWhere((product) => product.id == id);

    if (index >= 0) {
      products.removeAt(index);

      await _writeToFile(products);

      return true;
    }

    return false;
  }

  @override
  Future<List<Product>> get products async {
    final file = await _file;
    final content = await file.readAsString();
    final json = content.isNotEmpty ? jsonDecode(content) : [];

    return (json as List)
        .map((item) => Product.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }

  @override
  Future<Product> save(Product product) async {
    final List<Product> products = List.from(await this.products);
    products.add(product);

    await _writeToFile(products);

    return product;
  }

  Future<File> get _file async {
    if (_instance == null) {
      final tempPath = await getTemporaryDirectory();
      final path = join(tempPath.path, 'products.json');

      _instance = File(path);
      await _instance!.create();
    }

    return _instance!;
  }

  Future<void> _writeToFile(List<Product> products) async {
    final json = jsonEncode(products);
    final file = await _file;
    await file.writeAsString(json);
  }
}
