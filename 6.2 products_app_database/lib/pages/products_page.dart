import 'dart:io';
import 'dart:ui';

import 'package:desktop_context_menu/desktop_context_menu.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_alert/flutter_platform_alert.dart';
import 'package:intl/intl.dart';
import 'package:products_app/blocs/products/products_bloc.dart';
import 'package:products_app/widgets/app_drawer.dart';
import 'package:products_app/widgets/exception_widget.dart';
import 'package:products_app/widgets/loading_widget.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _scrollController = ScrollController();
  int? _rightClickProductId;

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
                child: BlocConsumer<ProductsBloc, ProductsState>(
                  listener: (context, state) {
                    if (state is DeletedProductState) {
                      _showDeleteConfirmedAlertDialog();
                    } else if (state is ErrorDeletingProductState) {
                      _showDeleteErrorAlertDialog();
                    }
                  },
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
                            child: Scrollbar(
                              controller: _scrollController,
                              child: SingleChildScrollView(
                                controller: _scrollController,
                                scrollDirection: Axis.vertical,
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
                                          DataCell(
                                            Listener(
                                              onPointerDown: (event) {
                                                if (event.kind ==
                                                        PointerDeviceKind
                                                            .mouse &&
                                                    event.buttons ==
                                                        kSecondaryMouseButton) {
                                                  setState(() {
                                                    _rightClickProductId =
                                                        product.id;
                                                  });
                                                }
                                              },
                                              onPointerUp: (event) {
                                                if (_rightClickProductId ==
                                                    null) {
                                                  return;
                                                }

                                                _showContextMenu(context);
                                              },
                                              child: Text(
                                                product.id.toString(),
                                              ),
                                            ),
                                          ),
                                          DataCell(Text(product.name)),
                                          DataCell(Text(product.description)),
                                          DataCell(Text(product.category)),
                                          DataCell(Text(
                                              product.quantity.toString())),
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

  void _showContextMenu(BuildContext context) async {
    final selectedItem = await showContextMenu(menuItems: [
      ContextMenuItem(
        title: 'Delete Product',
        onTap: () => _showDeleteConfirmationAlertDialog(context),
        shortcut: SingleActivator(
          LogicalKeyboardKey.keyD,
          meta: Platform.isMacOS,
          control: Platform.isWindows,
        ),
      ),
    ]);

    if (selectedItem == null) {
      setState(() {
        _rightClickProductId = null;
      });

      return;
    }

    selectedItem.onTap?.call();
  }

  void _showDeleteConfirmationAlertDialog(BuildContext context) async {
    final productsBloc = context.read<ProductsBloc>();

    final clickedButton = await FlutterPlatformAlert.showAlert(
      windowTitle: 'Delete product',
      text: 'Do you really want to remove this product?',
      alertStyle: AlertButtonStyle.yesNo,
      iconStyle: IconStyle.question,
    );

    if (clickedButton == AlertButton.yesButton) {
      productsBloc.deleteProduct(_rightClickProductId!);
    }

    setState(() {
      _rightClickProductId = null;
    });
  }

  void _showDeleteConfirmedAlertDialog() {
    FlutterPlatformAlert.showAlert(
      windowTitle: 'Product Deleted',
      text: 'The selected product has successfully been deleted!',
      alertStyle: AlertButtonStyle.ok,
      iconStyle: IconStyle.exclamation,
    );
  }

  void _showDeleteErrorAlertDialog() {
    FlutterPlatformAlert.showAlert(
      windowTitle: 'Error deleting product',
      text: 'An error has occurred while deleting the product!',
      alertStyle: AlertButtonStyle.ok,
      iconStyle: IconStyle.error,
    );
  }
}
