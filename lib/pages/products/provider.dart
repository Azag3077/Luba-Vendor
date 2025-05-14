import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/extensions/num_duration.dart';
import '../../core/routers/app_routes.dart';
import '../../models/product.dart';
import '../product/page.dart';

final productsPageFutureProvider =
    AsyncNotifierProvider<_Notifier, List<Product>>(_Notifier.new);

class _Notifier extends AsyncNotifier<List<Product>> {
  @override
  Future<List<Product>> build() async {
    await 1.5.seconds.delayed;
    return List.generate(23, (index) {
      return Product(
        id: 'id$index',
        name: 'Cheese Burger',
        imageUrl: '',
        isInStock: index % 3 == 0,
        price: 1550,
      );
    });
  }

  void onPressed(BuildContext context, [Product? product]) =>
      pushNamed(context, ProductPage.routeName, arguments: product);
}
