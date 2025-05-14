import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/place_holders.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../utils/utils.dart';
import 'provider.dart';

class AccountPage extends ConsumerWidget {
  const AccountPage({super.key});

  Widget _buildListTile({
    required String leadingIcon,
    required String text,
    required VoidCallback onTap,
    bool showTrailing = true,
    Color? color,
  }) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          leading: Image.asset(leadingIcon),
          horizontalTitleGap: 10.0,
          title: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13.0,
              color: color,
            ),
          ),
          trailing: showTrailing
              ? const Icon(
                  color: AppColors.grey,
                  Icons.arrow_forward,
                  size: 16.0,
                )
              : null,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 10.0,
          ),
        ),
        const Divider(
          height: 0,
          indent: 16.0,
          endIndent: 16.0,
          color: AppColors.greyOutline,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(accountPageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        actions: <Widget>[
          MaterialButton(
            onPressed: () {},
            elevation: 0,
            highlightElevation: 0,
            color: AppColors.green50,
            shape: const StadiumBorder(
              side: BorderSide(
                color: AppColors.green200,
                width: 2.0,
              ),
            ),
            child: const Row(
              spacing: 4.0,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  CupertinoIcons.ellipses_bubble,
                  size: 18.0,
                  color: AppColors.primary,
                ),
                Text(
                  'Support',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12.0),
        ],
      ),
      body: ListView(
        children: <Widget>[
          /// Profile Container
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 12.0,
            ),
            color: AppColors.text,
            child: Row(
              spacing: 10.0,
              children: <Widget>[
                const ImageLoader(
                  '',
                  width: 48.0,
                  height: 48.0,
                  radius: 24.0,
                ),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        r'Oluwabode Micheal',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Rider ID: 4214124',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(ImageAssetNames.award3),
              ],
            ),
          ),
          const SizedBox(height: 8.0),

          _buildListTile(
            text: 'Profile',
            leadingIcon: ImageAssetNames.profile,
            onTap: () => notifier.onProfile(context),
          ),
          _buildListTile(
            text: 'Reset PIN',
            leadingIcon: ImageAssetNames.lock,
            onTap: () => notifier.onResetPIN(context),
          ),
          _buildListTile(
            text: 'Payment & Payout',
            leadingIcon: ImageAssetNames.walletMoney,
            onTap: () => notifier.onPaymentPayout(context),
          ),
          _buildListTile(
            text: 'Notifications & Preferences',
            leadingIcon: ImageAssetNames.notification,
            onTap: () => notifier.onNotificationsPreferences(context),
          ),
          _buildListTile(
            text: 'Security',
            leadingIcon: ImageAssetNames.securitySafe,
            onTap: () => notifier.onSecurity(context),
          ),
          _buildListTile(
            text: 'Log Out',
            showTrailing: false,
            leadingIcon: ImageAssetNames.logout,
            onTap: () => notifier.onLogOut(context),
          ),
        ],
      ),
    );
  }
}
