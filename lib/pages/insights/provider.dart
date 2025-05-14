import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/routers/app_routes.dart';
import '../rating/page.dart';

final insightsPageProvider = Provider((_) => _Provider());

class _Provider {
  void onViewRatingsReport(BuildContext context) =>
      pushNamed(context, RatingPage.routeName);

  void onFilter() {}
}
