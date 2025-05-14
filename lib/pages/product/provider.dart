import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../core/routers/router.dart';

final productPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.imagePath = '',
    this.category = '',
    this.title = '',
    this.price = '',
    this.time = '',
    this.discount = '',
    this.desc = '',
    this.isInStock = false,
    this.canPop = true,
    this.hasChanges = false,
  });

  final String imagePath;
  final String category;
  final String title;
  final String price;
  final String time;
  final String discount;
  final String desc;
  final bool isInStock;
  final bool canPop;
  final bool hasChanges;

  _State copyWith({
    String? imagePath,
    String? category,
    String? title,
    String? price,
    String? time,
    String? discount,
    String? desc,
    bool? isInStock,
    bool? canPop,
    bool? hasChanges,
  }) {
    return _State(
      imagePath: imagePath ?? this.imagePath,
      category: category ?? this.category,
      title: title ?? this.title,
      price: price ?? this.price,
      time: time ?? this.time,
      discount: discount ?? this.discount,
      desc: desc ?? this.desc,
      isInStock: isInStock ?? this.isInStock,
      canPop: canPop ?? this.canPop,
      hasChanges: hasChanges ?? this.hasChanges,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is _State &&
        other.imagePath == imagePath &&
        other.category == category &&
        other.title == title &&
        other.price == price &&
        other.time == time &&
        other.discount == discount &&
        other.desc == desc &&
        other.isInStock == isInStock;
  }

  @override
  int get hashCode => Object.hashAll([
        imagePath,
        category,
        title,
        price,
        time,
        discount,
        desc,
        isInStock,
      ]);
}

class _Notifier extends AutoDisposeNotifier<_State> {
  @override
  _State build() => const _State();

  void updateCategory(String value) => state = state.copyWith(category: value);

  void updateTitle(String value) => state = state.copyWith(title: value);

  void updatePrice(String value) => state = state.copyWith(price: value);

  void updateDiscount(String value) => state = state.copyWith(discount: value);

  void updateDesc(String value) => state = state.copyWith(discount: value);

  void updateIsInStock(bool value) => state = state.copyWith(isInStock: value);

  void onAddProduct(BuildContext context, GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) return;
  }

  Future<void> onDeleteProduct1(BuildContext context) async {
    final shouldDelete = await showModalBottomSheet<bool?>(
      context: context,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 500),
      ),
      builder: (BuildContext context) {
        return CustomAlertBottomSheet(
          image: ImageAssetNames.error,
          title: 'Delete Product',
          subtitle: 'Are you sure you want to delete this product? '
              'You won’t be able to undo this.',
          actions: <Widget>[
            FilledButton(
              onPressed: () => pop(context, true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.red400,
              ),
              child: const Center(child: Text('Delete')),
            ),
          ],
        );
      },
    );

    if (!context.mounted || shouldDelete != true) return;

    // TODO: Do your deleting stuff here
  }

  Future<void> onDeleteProduct(BuildContext context) async {
    final result = await showModalBottomSheet<int?>(
      context: context,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 500),
      ),
      builder: (BuildContext context) {
        return CustomAlertBottomSheet(
          image: ImageAssetNames.success,
          title: 'Product added',
          subtitle: 'Your Product has been added to '
              'the list and is visible to customers',
          actions: <Widget>[
            OutlinedButton(
              onPressed: () => pop(context, 0),
              child: const Center(child: Text('View')),
            ),
            const SizedBox(height: 12.0),
            FilledButton(
              onPressed: () => pop(context, 1),
              child: const Center(child: Text('Add more Product')),
            ),
          ],
        );
      },
    );

    if (!context.mounted || result is! int) return;

    if (result == 0) return pop(context);
    if (result == 1) ref.invalidateSelf();
  }
}

class CustomAlertBottomSheet extends StatelessWidget {
  const CustomAlertBottomSheet({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.actions = const [],
  });

  final String image;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(image),
          const SizedBox(height: 16.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.hintColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 16.0),
          ...actions,
        ],
      ),
    );
  }
}
