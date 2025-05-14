import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/app_routes.dart';
import '../../models/order.dart';
import '../notifications/page.dart';
import 'components/bottom_sheet.dart';

final homePageProvider = NotifierProvider<_Notifier, _State>(_Notifier.new);

class _State {
  const _State({
    this.page = 0.0,
    this.index = 0,
  });

  final double page;
  final int index;

  _State copyWith({
    double? page,
    int? index,
  }) {
    return _State(
      page: page ?? this.page,
      index: index ?? this.index,
    );
  }
}

class _Notifier extends Notifier<_State> {
  @override
  _State build() => const _State();

  void updatePage(double value) => state = state.copyWith(page: value);

  Future<void> onUserProfile(BuildContext context) async {
    final choice = await showModalBottomSheet(
      context: context,
      builder: (_) => const ResProfileBottomSheetContent(),
    );

    if (choice == null || !context.mounted) return;

    /// Do you magic thingy...
  }

  void onBellIcon(BuildContext context) =>
      pushNamed(context, NotificationsPage.routeName);

  void onReject(BuildContext context, Order order) {}

  void onAccept(BuildContext context, Order order) {}

  void onCancel(BuildContext context, Order order) {}
}
