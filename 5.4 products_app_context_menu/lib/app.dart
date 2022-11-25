import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_app/pages/add_product_page.dart';
import 'package:products_app/pages/products_page.dart';
import 'package:products_app/repositories/products_repository.dart';
import 'package:products_app/routing/routes.dart';
import 'package:products_app/services/memory/memory_products_service.dart';
import 'package:products_app/services/products_service.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<ProductsService>(create: (_) => MemoryProductsService()),
          RepositoryProvider(
            create: (context) => ProductsRepository(
              productsService: context.read(),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'People App',
          initialRoute: RouteNames.products,
          routes: {
            RouteNames.products: (_) => ProductsPage(),
            RouteNames.add: (_) => const AddProductPage(),
          },
          theme: ThemeData(
            primarySwatch: Colors.red,
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.zero),
              ),
            ),
          ),
        ),
      );
}
