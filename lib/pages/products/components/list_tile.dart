import 'package:flutter/material.dart';

import '../../../components/place_holders.dart';
import '../../../core/constants/colors.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../models/product.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    super.key,
    required this.product,
    required this.onTap,
  });

  final Product product;
  final VoidCallback onTap;

  Color get _stockBgColor =>
      product.isInStock ? AppColors.green50 : AppColors.containerFg;

  Color get _stockFgColor =>
      product.isInStock ? AppColors.primary : const Color(0xFF666666);

  String get _stockText => product.isInStock ? 'In Stock' : 'Out of Stock';

  @override
  Widget build(BuildContext context) {
    const radius = 8.0;

    return ListTile(
      key: ValueKey(product.id),
      onTap: onTap,
      leading: DecoratedBox(
        position: DecorationPosition.foreground,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: AppColors.greyOutline,
            width: 1.5,
          ),
        ),
        child: ImageLoader(
          product.imageUrl,
          width: 60.0,
          height: 60.0,
          radius: radius,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        product.name,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Color(0xFF1A1A1A),
          fontSize: 13.0,
        ),
      ),
      subtitle: Text(
        product.price.toPriceWithCurrency(),
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          color: Color(0xFF666666),
          fontSize: 13.0,
        ),
      ),
      trailing: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 4.0,
        ),
        decoration: BoxDecoration(
          color: _stockBgColor,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Text(
          _stockText,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: _stockFgColor,
            fontSize: 13.0,
          ),
        ),
      ),
    );
  }
}
