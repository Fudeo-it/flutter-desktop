import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(32),
                          child: Text(
                            'Products',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.maxFinite,
                            height: double.maxFinite,
                            child: SingleChildScrollView(
                              child: DataTable(
                                headingTextStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                columns: [
                                  'Id',
                                  'Name',
                                  'Description',
                                  'Category',
                                  'Quantity',
                                  'Created At',
                                ]
                                    .map((columnName) =>
                                        DataColumn(label: Text(columnName)))
                                    .toList(growable: false),
                                rows: state.products
                                    .map(
                                      (product) => DataRow(cells: [
                                        DataCell(Text(product.id.toString())),
                                        DataCell(Text(product.name)),
                                        DataCell(Text(product.description)),
                                        DataCell(Text(product.category)),
                                        DataCell(
                                            Text(product.quantity.toString())),
                                        DataCell(Text(DateFormat(
                                                DateFormat.YEAR_MONTH_DAY)
                                            .format(product.createdAt))),
                                      ]),
                                    )
                                    .toList(growable: false),
                              ),
                            ),
                          ),
                        ),
                      ],
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
