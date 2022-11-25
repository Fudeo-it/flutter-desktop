part of 'add_product_cubit.dart';

abstract class AddProductState extends Equatable {
  const AddProductState();

  @override
  List<Object> get props => [];
}

class AddProductDefaultState extends AddProductState {}

class AddingProductState extends AddProductState {}

class AddedProductState extends AddProductState {
  final Product product;

  const AddedProductState(this.product);

  @override
  List<Object> get props => [product];
}

class ErrorAddProductState extends AddProductState {}
