import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/product.dart';

abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoading extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  final String sortingOrder;

  ProductsLoaded({required this.products, required this.sortingOrder});
}

class ProductsFiltered extends ProductsState {
  final List<Product> products;
  final int start;
  final int end;

  ProductsFiltered({required this.products, required this.start, required this.end});
}

class ProductsError extends ProductsState {
  final String message;

  ProductsError(this.message);
}

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  final List<Product> _allProducts = [
    Product(
      id: 1,
      name: 'فواكه',
      description: 'fruits description',
      price: 20,
      quantity: 1,
      imageUrl: 'https://www.fruitsmith.com/pub/media/mageplaza/blog/post/s/e/seedless_fruits.jpg',
      categoryId: 2,
      totalRating: 3.5,
      counterFiveStars: 3,
      counterFourStars: 6,
      counterThreeStars: 7,
      counterTwoStars: 3,
      counterOneStars: 2,
      caloriesPer100Gram: 50,
      expiryMonths: 6,
    ),
    Product(
      id: 2,
      name: 'سلطه فواكه',
      description: 'fruit salad description',
      price: 30,
      quantity: 1,
      imageUrl: 'https://images.healthshots.com/healthshots/en/uploads/2022/04/17151621/fruit-salad.jpg',
      categoryId: 2,
      totalRating: 3.5,
      counterFiveStars: 3,
      counterFourStars: 6,
      counterThreeStars: 7,
      counterTwoStars: 3,
      counterOneStars: 2,
      caloriesPer100Gram: 80,
      expiryMonths: 6,
    ),
  ];

  void loadProducts({String sortingOrder = 'name'}) {
    emit(ProductsLoading());

    try {
      List<Product> sortedProducts = List<Product>.from(_allProducts);

      if (sortingOrder == 'asc') {
        sortedProducts.sort((a, b) => a.price.compareTo(b.price));
      } else if (sortingOrder == 'desc') {
        sortedProducts.sort((a, b) => b.price.compareTo(a.price));
      } else if (sortingOrder == 'name') {
        sortedProducts.sort((a, b) => a.name.compareTo(b.name));
      }

      emit(ProductsLoaded(products: sortedProducts, sortingOrder: sortingOrder));
    } catch (e) {
      emit(ProductsError('فشل تحميل المنتجات'));
    }
  }

  void filterProductsByPrice(int start, int end) {
    emit(ProductsLoading());

    try {
      List<Product> filteredProducts = _allProducts.where((product) {
        return product.price >= start && product.price <= end;
      }).toList();

      emit(ProductsFiltered(products: filteredProducts, start: start, end: end));
    } catch (e) {
      emit(ProductsError('فشل في تصفية المنتجات حسب السعر'));
    }
  }
}
