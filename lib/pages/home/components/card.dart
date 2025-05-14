import 'package:flutter/material.dart';

import '../../../components/chip.dart';
import '../../../core/constants/assets.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/constants.dart';
import '../../../core/extensions/datetime.dart';
import '../../../core/extensions/num_duration.dart';
import '../../../models/order.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.order,
    required this.onReject,
    required this.onAccept,
  });

  final Order order;
  final VoidCallback onReject;
  final VoidCallback onAccept;

  Widget _buildAddressRow({
    required String label,
    required String address,
  }) {
    return Row(
      spacing: 4.0,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 2.0),
          child: Image.asset(
            ImageAssetNames.location,
            color: AppColors.secText,
            width: 13.0,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(width: 4.0),
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.hintColor,
                  fontSize: 11.0,
                ),
              ),
              Text(
                address,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.secText,
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildIconTextRow({
    required String icon,
    required String text,
  }) {
    return Row(
      spacing: 4.0,
      children: <Widget>[
        Image.asset(
          icon,
          width: 18.0,
          height: 18.0,
        ),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.hintColor,
            fontSize: 11.0,
          ),
        ),
      ],
    );
  }

  Widget _buildItemPriceRow({
    required String text,
    required String value,
    bool bold = false,
  }) {
    final style = TextStyle(
      fontWeight: bold ? FontWeight.w600 : FontWeight.w500,
      color: bold ? AppColors.text : AppColors.secText,
      fontSize: 13.0,
    );
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(text, style: style),
          Text(value, style: style),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(6.0),
        border: Border.all(color: AppColors.greyOutline),
      ),
      child: Column(
        spacing: 12.0,
        children: <Widget>[
          /// The Order ID & Time
          Row(
            spacing: 4.0,
            children: <Widget>[
              Image.asset(ImageAssetNames.orderFill),
              Text(
                'Order #${order.id}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
              const Spacer(),
              CustomChip2(
                icon: order.status.isPending
                    ? const Icon(
                        size: 16.0,
                        Icons.access_time,
                        color: AppColors.green600,
                      )
                    : Image.asset(ImageAssetNames.truckFast),
                text: order.createdOn.timeAgo(),
              ),
            ],
          ),

          /// The Pickup and Drop-off Address
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 16.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(8.0),
              color: const Color(0x08007AFF),
            ),
            child: Column(
              spacing: 8.0,
              children: <Widget>[
                _buildAddressRow(
                  label: 'Pickup',
                  address: order.pickupAddress,
                ),
                _buildAddressRow(
                  label: 'Drop-off',
                  address: order.dropOffAddress,
                ),
              ],
            ),
          ),

          /// VIew Order Expansion
          ExpansionTile(
            title: const Text(
              'View order',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: AppColors.secText,
              ),
            ),
            tilePadding: const EdgeInsets.symmetric(horizontal: 12.0),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(6.0),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(6.0),
            ),
            visualDensity: const VisualDensity(
              horizontal: -4.0,
              vertical: -4.0,
            ),
            collapsedBackgroundColor: AppColors.textFieldBg,
            backgroundColor: AppColors.textFieldBg,
            children: <Widget>[
              _buildIconTextRow(
                icon: ImageAssetNames.order,
                text: 'Customer Order',
              ),
              const SizedBox(height: 4.0),
              ...[
                '1x Rice and chicken',
                '2x Chicken',
                '2x Bottle water',
              ].map((item) {
                return _buildItemPriceRow(
                  text: item,
                  value: 3000.toPriceWithCurrency(),
                );
              }),
              Divider(color: Colors.grey.shade300),
              _buildItemPriceRow(
                text: 'Discount',
                value: '20%',
              ),
              Divider(color: Colors.grey.shade300),
              _buildItemPriceRow(
                text: 'Total',
                value: 21500.toPriceWithCurrency(),
                bold: true,
              ),
              Divider(color: Colors.grey.shade300),

              ///
              const SizedBox(height: 8.0),
              _buildIconTextRow(
                icon: ImageAssetNames.menuBoard,
                text: 'Buyer note',
              ),
              const SizedBox(height: 4.0),
              const Text(
                'Please ensure that any fragile '
                'items are handled with care. '
                'I appreciate our attention to details',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.secText,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(height: 12.0),
            ],
          ),

          /// The Reject & Accept Button
          if (order.status.isPending)
            Row(
              spacing: 8.0,
              children: <Widget>[
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onReject,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppColors.red400),
                      foregroundColor: AppColors.red400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(kButtonRadius),
                      ),
                      padding: EdgeInsets.zero,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.red400,
                    ),
                    label: const Text('Reject'),
                  ),
                ),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: onAccept,
                    style: FilledButton.styleFrom(
                      padding: EdgeInsets.zero,
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14.0,
                      ),
                    ),
                    icon: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    label: const Text('Accept'),
                  ),
                ),
              ],
            )

          /// The 'Track order' Button
          else if (order.status.isOngoing)
            OutlinedButton(
              onPressed: onReject,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primary),
                foregroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kButtonRadius),
                ),
                padding: EdgeInsets.zero,
                textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                ),
              ),
              child: const Center(child: Text('Track order')),
            ),
        ],
      ),
    );
  }
}
