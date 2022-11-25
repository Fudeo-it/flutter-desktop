import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:products_app/models/product.dart';
import 'package:products_app/services/products_service.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseProductsService extends ProductsService {
  static const _tableName = 'Products';
  static const _idColumn = 'id';
  static const _nameColumn = 'name';
  static const _descriptionColumn = 'description';
  static const _categoryColumn = 'category';
  static const _quantityColumn = 'quantity';
  static const _createdAtColumn = 'created_at';

  Database? _instance;

  DatabaseProductsService() {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
    }

    databaseFactory = databaseFactoryFfi;
  }

  @override
  FutureOr<bool> delete(int id) async {
    final database = await _database;
    return await database
            .delete(_tableName, where: '$_idColumn = ?', whereArgs: [id]) >=
        0;
  }

  @override
  Future<List<Product>> get products async {
    final database = await _database;

    final resultSet = await database.rawQuery('SELECT * FROM $_tableName');
    return resultSet
        .map(
          (row) => Product(
            id: row[_idColumn] as int,
            name: row[_nameColumn] as String,
            description: row[_descriptionColumn] as String,
            category: row[_categoryColumn] as String,
            quantity: row[_quantityColumn] as int,
            createdAt: DateTime.fromMillisecondsSinceEpoch(
                row[_createdAtColumn] as int),
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<Product> save(Product product) async {
    final database = await _database;

    database.insert(_tableName, {
      _idColumn: product.id,
      _nameColumn: product.name,
      _descriptionColumn: product.description,
      _categoryColumn: product.category,
      _quantityColumn: product.quantity,
      _createdAtColumn: product.createdAt.millisecondsSinceEpoch,
    });

    return product;
  }

  Future<Database> get _database async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'products.sqlite');

    return _instance ??=
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('CREATE TABLE $_tableName ('
          '$_idColumn INTEGER PRIMARY KEY, '
          '$_nameColumn TEXT NOT NULL, '
          '$_descriptionColumn TEXT NOT NULL, '
          '$_categoryColumn TEXT NOT NULL, '
          '$_quantityColumn INTEGER NOT NULL,'
          '$_createdAtColumn INTEGER NOT NULL'
          ')');
    });
  }
}
