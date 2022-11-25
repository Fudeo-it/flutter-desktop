import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_app/blocs/products/products_bloc.dart';
import 'package:products_app/widgets/app_drawer.dart';
import 'package:products_app/widgets/exception_widget.dart';
import 'package:products_app/widgets/loading_widget.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => ProductsBloc(
          productsRepository: context.read(),
        )..fetchProducts(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Products'),
          ),
          body: Row(
            children: [
              const AppDrawer(),
              Expanded(
                child: BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                  if (state is ErrorProductsState) {
                    return const ExceptionWidget(
                      title: 'Uh Oh!',
                      subtitle: 'An error has occurred',
                    );
                  } else if (state is NoProductsState) {
                    return const ExceptionWidget(
                      title: 'Ops!',
                      subtitle: 'No products found',
                    );
                  } else if (state is LoadedProductsState) {
                    return ListView.builder(
                      itemBuilder: (context, index) => ListTile(
                        title: Text(
                            '${state.products[index].name} (${state.products[index].category})'),
                        subtitle: Text(state.products[index].description),
                        trailing:
                            Text(state.products[index].quantity.toString()),
                      ),
                      itemCount: state.products.length,
                    );
                  }

                  return const LoadingWidget();
                }),
              ),
            ],
          ),
        ),
      );
}
