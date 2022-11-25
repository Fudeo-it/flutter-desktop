import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_app/models/product.dart';
import 'package:products_app/repositories/products_repository.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final ProductsRepository productsRepository;

  AddProductCubit({required this.productsRepository})
      : super(AddProductDefaultState());

  void addProduct({
    required String name,
    required String description,
    required String category,
    required int quantity,
  }) async {
    emit(AddingProductState());

    try {
      final product = await productsRepository.save(
        id: DateTime.now().millisecondsSinceEpoch,
        name: name,
        description: description,
        category: category,
        quantity: quantity,
      );

      emit(AddedProductState(product));
    } catch (e) {
      emit(ErrorAddProductState());
    }
  }
}
