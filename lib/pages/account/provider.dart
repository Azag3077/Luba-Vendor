import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/app_routes.dart';
import '../profile/page.dart';
import '../payment_payout/page.dart';
import '../reset_pin/page.dart';
import '../settings/page.dart';

final accountPageProvider = Provider((_) => _Provider());

class _Provider {
  void onProfile(BuildContext context) =>
      pushNamed(context, ProfilePage.routeName);

  void onResetPIN(BuildContext context) =>
      pushNamed(context, ResetPinPage.routeName);

  void onPaymentPayout(BuildContext context) =>
      pushNamed(context, PaymentPayoutPage.routeName);

  void onNotificationsPreferences(BuildContext context) =>
      pushNamed(context, SettingsPage.routeName);

  void onSecurity(BuildContext context) =>
      pushNamed(context, SettingsPage.routeName);

  void onLogOut(BuildContext context) =>
      pushNamed(context, SettingsPage.routeName);
}
