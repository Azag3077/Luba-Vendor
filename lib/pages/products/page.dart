import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/no_order_page.dart';
import '../../components/place_holders.dart';
import '../../components/textfields.dart';
import '../../core/constants/colors.dart';
import 'components/list_tile.dart';
import 'provider.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  static const routeName = '/products';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(productsPageFutureProvider);
    final notifier = ref.read(productsPageFutureProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Products')),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              spacing: 8.0,
              children: <Widget>[
                const Expanded(
                  child: CustomTextField(
                    prefixIconData: Icons.search,
                    hintText: 'Search from products',
                    inactiveBorderColor: Colors.transparent,
                    margin: EdgeInsets.zero,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  style: IconButton.styleFrom(
                    padding: const EdgeInsets.all(14.0),
                    backgroundColor: AppColors.textFieldBg,
                  ),
                  icon: const Icon(Icons.filter_list),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          const Divider(
            color: AppColors.greyOutline,
            height: 0,
          ),
          Expanded(
            child: asyncValue.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(16.0),
                child: CustomLoadingWidget(showBottom: false),
              ),
              error: (error, stackTrace) {
                return Column(
                  spacing: 8.0,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'An error occurred, please try again later.',
                    ),
                    FilledButton(
                      onPressed: () =>
                          ref.refresh(productsPageFutureProvider.notifier),
                      child: const Text('Retry'),
                    ),
                  ],
                );
              },
              data: (data) {
                if (data.isEmpty) {
                  return const NoOrderPage('No product yet');
                }

                return RefreshIndicator(
                  onRefresh: () =>
                      ref.refresh(productsPageFutureProvider.future),
                  child: ListView.separated(
                    key: const PageStorageKey('ProductsPageKey'),
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    itemCount: data.length,
                    separatorBuilder: (_, __) => const Divider(
                      color: AppColors.greyOutline,
                      height: 0,
                      indent: 12.0,
                      endIndent: 12.0,
                    ),
                    itemBuilder: (context, int index) {
                      final product = data.elementAt(index);

                      return ProductListTile(
                        onTap: () => notifier.onPressed(context, product),
                        product: product,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => notifier.onPressed(context),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
