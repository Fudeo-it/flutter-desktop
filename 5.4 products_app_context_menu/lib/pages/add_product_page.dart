import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_app/cubits/add_product/add_product_cubit.dart';
import 'package:products_app/routing/routes.dart';
import 'package:products_app/widgets/app_drawer.dart';
import 'package:products_app/widgets/exception_widget.dart';
import 'package:products_app/widgets/loading_widget.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  final _quantityController = TextEditingController();

  @override
  void dispose() async {
    _nameController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _quantityController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => AddProductCubit(
          productsRepository: context.read(),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Add Product'),
          ),
          body: Row(
            children: [
              const AppDrawer(),
              Expanded(
                child: BlocConsumer<AddProductCubit, AddProductState>(
                    listener: (context, state) {
                  _shouldNavigateToPeoplePage(context, state);
                }, builder: (context, state) {
                  if (state is ErrorAddProductState) {
                    return const ExceptionWidget(
                      title: 'Uh Oh!',
                      subtitle: 'An error has occurred',
                    );
                  } else if (state is AddingProductState) {
                    return const LoadingWidget();
                  }

                  return _form(context);
                }),
              ),
            ],
          ),
        ),
      );

  Widget _form(BuildContext context) {
    final fields = [
      FormWidget('Name', controller: _nameController),
      FormWidget(
        'Description',
        controller: _descriptionController,
        lines: 5,
      ),
      FormWidget('Category', controller: _categoryController),
      FormWidget(
        'Quantity',
        controller: _quantityController,
        type: TextInputType.number,
      ),
    ];

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(32.0),
          child:
              Text('Add Product', style: Theme.of(context).textTheme.headline4),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            itemBuilder: (context, index) => fields[index],
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemCount: fields.length,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () => context.read<AddProductCubit>().addProduct(
                    name: _nameController.text,
                    description: _descriptionController.text,
                    category: _categoryController.text,
                    quantity: int.tryParse(_quantityController.text) ?? 0,
                  ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Save'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _shouldNavigateToPeoplePage(
      BuildContext context, AddProductState state) async {
    if (state is AddedProductState) {
      await Navigator.pushReplacementNamed(context, RouteNames.products);
    }
  }
}

class FormWidget extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final TextInputType type;
  final int? lines;

  const FormWidget(
    this.name, {
    Key? key,
    required this.controller,
    this.type = TextInputType.text,
    this.lines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                name,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Expanded(
              flex: 4,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.name,
                minLines: lines,
                maxLines: lines,
              ),
            ),
          ],
        ),
      );
}
