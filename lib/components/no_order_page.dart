import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../core/constants/assets.dart';
import '../core/constants/colors.dart';

class NoOrderPage extends StatelessWidget {
  const NoOrderPage(
    this.text, {
    super.key,
    this.image = ImageAssetNames.redBike,
  });

  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 24.0,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(ImageAssetNames.blankList)
              .animate()
              .fadeIn(duration: 600.ms)
              .scale(duration: 600.ms, curve: Curves.easeOutBack),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 56.0),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.hintColor,
                fontSize: 12.0,
              ),
            ),
          )
              .animate()
              .slideY(begin: 0.3, duration: 500.ms)
              .fadeIn(duration: 500.ms),
          const SizedBox(height: 80.0),
        ],
      ),
    );
  }
}
