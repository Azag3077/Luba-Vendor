import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/colors.dart';
import 'provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  static const routeName = '/profile';

  Widget _buildTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16.0,
        top: 16.0,
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showVerifiedBadge = false,
  }) {
    return Column(
      children: <Widget>[
        ListTile(
          onTap: onTap,
          horizontalTitleGap: 10.0,
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.hintColor,
              letterSpacing: 0,
              fontSize: 13.0,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.text,
              letterSpacing: 0,
              fontSize: 13.0,
            ),
          ),
          trailing: Row(
            spacing: 8.0,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (showVerifiedBadge)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12.0,
                    vertical: 4.0,
                  ),
                  decoration: const ShapeDecoration(
                    shape: StadiumBorder(
                      side: BorderSide(
                        color: AppColors.green200,
                        width: 1.5,
                      ),
                    ),
                    color: AppColors.green50,
                  ),
                  child: const Text(
                    'Verified',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                      fontSize: 10.0,
                    ),
                  ),
                ),
              const Icon(
                Icons.drive_file_rename_outline,
                color: AppColors.hintColor,
                size: 18.0,
              ),
            ],
          ),
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 6.0,
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
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        children: <Widget>[
          /// Business Profile
          _buildTitle('Business Profile'),

          _buildListTile(
            title: 'Business Name',
            subtitle: 'Iya moria',
            onTap: () => notifier.onBusinessName(context),
          ),
          _buildListTile(
            title: 'Business Location',
            subtitle: r'Unilag road, Akoka',
            onTap: () => notifier.onBusinessLocation(context),
          ),
          _buildListTile(
            title: 'Phone Number',
            subtitle: '+234 (0801322431)',
            onTap: () => notifier.onPhoneNumber(context),
          ),

          /// Personal Details
          const SizedBox(height: 8.0),
          _buildTitle('Personal Details'),

          _buildListTile(
            title: 'Full Name',
            subtitle: 'Jennifer Moria',
            onTap: () => notifier.onFullName(context),
          ),
          _buildListTile(
            title: 'Password',
            subtitle: '***********',
            onTap: () => notifier.onPassword(context),
          ),
          _buildListTile(
            title: 'Email Address',
            subtitle: 'Iyamoria@gmail.com',
            showVerifiedBadge: true,
            onTap: () => notifier.onEmailAddress(context),
          ),
        ],
      ),
    );
  }
}
