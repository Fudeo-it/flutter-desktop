import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:products_app/models/product.dart';
import 'package:products_app/repositories/products_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsRepository productsRepository;

  ProductsBloc({required this.productsRepository})
      : super(LoadingProductsState()) {
    on<FetchProductsEvent>(_onFetch);
  }

  void fetchProducts() => add(FetchProductsEvent());

  void _onFetch(FetchProductsEvent event, Emitter<ProductsState> emit) async {
    emit(LoadingProductsState());

    try {
      final products = await productsRepository.products;
      emit(
        products.isNotEmpty ? LoadedProductsState(products) : NoProductsState(),
      );
    } catch (e) {
      emit(ErrorProductsState());
    }
  }
}
