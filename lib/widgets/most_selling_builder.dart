import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fruitshub/API/products_management.dart';
import 'package:fruitshub/auth/helpers/shared_pref_manager.dart';
import 'package:fruitshub/models/product.dart';
import 'package:fruitshub/widgets/error_indicator.dart';
import '../screens/sub_screens/details_screen.dart';
import 'most_selling_product_card.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MostSellingBuilder extends StatefulWidget {
  final String sortDirection;
  final String sortBy;
  final bool startfilter;

  const MostSellingBuilder({
    super.key,
    required this.sortDirection,
    required this.sortBy,
    required this.startfilter,
  });

  @override
  State<MostSellingBuilder> createState() => _MostSellingBuilderState();
}

class _MostSellingBuilderState extends State<MostSellingBuilder> {
  static const _pageSize = 6;
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    try {
      final response = await ProductsManagement().getAllProducts(
        token: await SharedPrefManager().getData('token'),
        itemsPerPage: _pageSize.toString(),
        pageNumber: pageKey.toString(),
        sortDirection: widget.sortBy == 'name' ? 'asc' : widget.sortDirection,
        sortBy: widget.sortBy,
      );
      final newItems = Product.fromJsonList(jsonDecode(response.body)['items']);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_fetchPage);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PagedGridView<int, Product>(
        pagingController: _pagingController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 2.5,
          mainAxisSpacing: 8,
          crossAxisSpacing: MediaQuery.of(context).size.width * 0.03,
        ),
        builderDelegate: PagedChildBuilderDelegate<Product>(
          itemBuilder: (context, item, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(product: item),
                ),
              );
            },
            child: ProductCard(product: item),
          ),
          firstPageProgressIndicatorBuilder: (context) =>
              const SpinKitThreeBounce(color: Colors.green, size: 50.0),
          newPageProgressIndicatorBuilder: (context) =>
              const SpinKitThreeBounce(color: Colors.green, size: 50.0),
          noItemsFoundIndicatorBuilder: (context) =>
              const Center(child: Text('No products available')),
          firstPageErrorIndicatorBuilder: (context) => ErrorIndicator(
            error: _pagingController.error,
            onTryAgain: () => _pagingController.refresh(),
          ),
          newPageErrorIndicatorBuilder: (context) => ErrorIndicator(
            error: _pagingController.error,
            onTryAgain: () => _pagingController.retryLastFailedRequest(),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
