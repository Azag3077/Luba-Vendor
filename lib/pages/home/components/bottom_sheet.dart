import 'package:flutter/material.dart';

import '../../../components/place_holders.dart';
import '../../../core/constants/colors.dart';
import '../../../core/routers/router.dart';

class ResProfileBottomSheetContent extends StatelessWidget {
  const ResProfileBottomSheetContent({super.key});

  Widget _buildListTile({
    required String text,
    required String imageUrl,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: IgnorePointer(
        child: Radio(
          value: isActive,
          groupValue: true,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (_) {},
        ),
      ),
      horizontalTitleGap: 0,
      title: Row(
        children: <Widget>[
          ImageLoader(
            imageUrl,
            width: 38.0,
            height: 38.0,
            radius: 19.0,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.secText,
                fontSize: 12.0,
              ),
            ),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
      trailing: isActive
          ? Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: AppColors.green50,
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: const Color(0xFFA5E3BF)),
              ),
              child: const Text('Active'),
            )
          : null,
      contentPadding: const EdgeInsets.only(left: 8.0, right: 20.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            bottom: 8.0,
          ),
          child: Text(
            'Your restaurant',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        ...[
          r'Mama’s Kitchen – Ikeja Brazil',
          r'QuickBite – Yaba',
          r'QuickBite – Yaba',
        ].map((res) {
          return _buildListTile(
            text: res,
            imageUrl: '',
            isActive: res.startsWith('M'),
            onTap: () => pop(context, res),
          );
        }),
      ],
    );
  }
}
