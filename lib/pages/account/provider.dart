import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/app_routes.dart';
import '../boost_earnings/page.dart';
import '../rating/page.dart';
import '../reset_pin/page.dart';
import '../settings/page.dart';

final accountPageProvider = Provider((_) => _Provider());

class _Provider {
  void onProfile(BuildContext context) =>
      pushNamed(context, SettingsPage.routeName);

  void onResetPIN(BuildContext context) =>
      pushNamed(context, ResetPinPage.routeName);

  void onPaymentPayout(BuildContext context) =>
      pushNamed(context, SettingsPage.routeName);

  void onNotificationsPreferences(BuildContext context) =>
      pushNamed(context, SettingsPage.routeName);

  void onSecurity(BuildContext context) =>
      pushNamed(context, SettingsPage.routeName);

  void onLogOut(BuildContext context) =>
      pushNamed(context, SettingsPage.routeName);
}
