part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class FetchProductsEvent extends ProductsEvent {}

class DeleteProductEvent extends ProductsEvent {
  final int id;

  const DeleteProductEvent(this.id);

  @override
  List<Object> get props => [id];
}
