import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/colors.dart';
import 'provider.dart';

class AccountPage1 extends ConsumerWidget {
  const AccountPage1({super.key});

  static const routeName = '/account';

  Widget _buildListTile({
    required IconData leftIcon,
    required String text,
    required VoidCallback onTap,
    bool showTrailing = true,
    Color? color,
  }) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          leading: Icon(
            leftIcon,
            size: 20.0,
            color: color ?? Colors.grey.shade600,
          ),
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
                  Icons.chevron_right,
                  size: 16.0,
                )
              : null,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 10.0,
          ),
        ),
        const Divider(height: 0),
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
            // onPressed: () => notifier.onChatWithUs(context),
            onPressed: () {},
            height: 0,
            elevation: 0,
            // color: AppColors.orderFood,
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: const Row(
              spacing: 4.0,
              children: <Widget>[
                Icon(
                  CupertinoIcons.chat_bubble_2,
                  size: 15.0,
                  color: AppColors.text,
                ),
                Text(
                  'Chat with us',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16.0),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Personal',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            _buildListTile(
              onTap: () {},
              // onTap: () => notifier.onProfileDetails(context),
              leftIcon: Icons.account_circle_outlined,
              text: 'Profile details',
            ),
            _buildListTile(
              onTap: () {},
              // onTap: () => notifier.onPaymentMethod(context),
              leftIcon: Icons.credit_card,
              text: 'Payment method',
            ),
            _buildListTile(
              onTap: () {},
              // onTap: () => notifier.onNotifications(context),
              leftIcon: Icons.notifications_outlined,
              text: 'Notifications',
            ),
            _buildListTile(
              onTap: () {},
              // onTap: () => notifier.onAddresses(context),
              leftIcon: Icons.location_on_outlined,
              text: 'Addresses',
            ),
            _buildListTile(
              onTap: () {},
              // onTap: () => notifier.onReferAndEarn(context),
              leftIcon: Icons.access_time,
              text: 'Refer and earn',
            ),
            _buildListTile(
              onTap: () {},
              // onTap: () => notifier.onPrivacyAndSecurity(context),
              leftIcon: Icons.lock_outline_rounded,
              text: 'Privacy and security',
            ),
            const SizedBox(height: 32.0),
            const Text(
              'Support',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
            _buildListTile(
              onTap: () {},
              // onTap: () => notifier.onFAQs(context),
              leftIcon: CupertinoIcons.question_circle,
              text: 'FAQs',
            ),
            _buildListTile(
              onTap: () {},
              // onTap: () => notifier.onContactUs(context),
              leftIcon: CupertinoIcons.phone,
              text: 'Contact Us',
            ),
            _buildListTile(
              onTap: () {},
              // onTap: () => notifier.onLogout(context),
              leftIcon: Icons.login,
              text: 'Log out',
              color: AppColors.red,
              showTrailing: false,
            ),
          ],
        ),
      ),
    );
  }
}
