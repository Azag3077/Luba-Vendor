import 'package:flutter/material.dart';

import '../../../core/constants/colors.dart';
import '../../../core/extensions/num_duration.dart';

class CustomTableCell extends StatelessWidget {
  const CustomTableCell({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.isPrice = false,
  });

  final String icon;
  final String label;
  final num value;
  final bool isPrice;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 16.0,
      ),
      child: Row(
        spacing: 12.0,
        children: <Widget>[
          Image.asset(icon),
          Expanded(
            child: Column(
              spacing: 4.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.secText,
                    fontSize: 11.0,
                  ),
                ),
                TweenAnimationBuilder(
                  tween: Tween(begin: 0, end: value),
                  duration: const Duration(seconds: 2),
                  curve: Curves.easeOut,
                  builder: (context, value, _) {
                    return Text(
                      isPrice
                          ? value.toPriceWithCurrency()
                          : '${value.toInt()}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16.0,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
