import 'package:bloc/bloc.dart';
import 'package:internship_assignment/models/product_model.dart';
import 'package:internship_assignment/respositories/product_respository.dart';

// Events
abstract class ProductEvent {}

class FetchProducts extends ProductEvent {}

// States
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);
}

class ProductError extends ProductState {
  final String error;

  ProductError(this.error);
}

// Bloc
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;

  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final products = await productRepository.getProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
  }
}
