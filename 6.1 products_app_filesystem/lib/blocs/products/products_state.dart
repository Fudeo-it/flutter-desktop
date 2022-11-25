part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class LoadingProductsState extends ProductsState {}

class LoadedProductsState extends ProductsState {
  final List<Product> products;

  const LoadedProductsState(this.products);

  @override
  List<Object> get props => [products];
}

class NoProductsState extends ProductsState {}

class ErrorProductsState extends ProductsState {}

class DeletingProductState extends ProductsState {}

class DeletedProductState extends ProductsState {}

class ErrorDeletingProductState extends ProductsState {}
