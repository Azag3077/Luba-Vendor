import 'package:flutter/material.dart';

import '../../../components/place_holders.dart';
import '../../../core/constants/colors.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.username,
    required this.imageUrl,
    required this.onPressed,
  });

  final String username;
  final String imageUrl;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: 0,
      elevation: 0,
      highlightElevation: 0,
      color: AppColors.green50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
        side: const BorderSide(
          color: AppColors.green600,
          width: 1.5,
        ),
      ),
      padding: EdgeInsets.zero,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 148.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            DecoratedBox(
              position: DecorationPosition.foreground,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.green600,
                  width: 2.0,
                ),
              ),
              child: ImageLoader(
                imageUrl,
                height: 34.0,
                width: 34.0,
                radius: 17.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                username,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.secText,
                  fontSize: 11.0,
                ),
              ),
            ),
            const SizedBox(width: 3.0),
            const Icon(
              Icons.expand_more,
              size: 14.0,
            ),
            const SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }
}
