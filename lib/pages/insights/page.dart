import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/popup_button.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import 'components/table_cell.dart';
import 'provider.dart';

class InsightsPage extends ConsumerWidget {
  const InsightsPage({super.key});

  List<String> get _daysOfTheWeek =>
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  List<String> get _monsOfTheYear => [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(insightsPageProvider);

    const padding = EdgeInsets.symmetric(horizontal: 16.0);
    const borderSide = BorderSide(color: AppColors.greyOutline);

    const bottomLabelHeight = 24.0;

    return Scaffold(
      appBar: AppBar(title: const Text('Insights')),
      body: ListView(
        children: <Widget>[
          /// Total revenue
          const CustomTableCell(
            icon: ImageAssetNames.currency,
            label: 'Total revenue',
            value: 11500,
            isPrice: true,
          ),

          ///
          Table(
            border: const TableBorder(
              top: borderSide,
              bottom: borderSide,
              verticalInside: borderSide,
              horizontalInside: borderSide,
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: const <TableRow>[
              TableRow(
                children: <Widget>[
                  CustomTableCell(
                    icon: ImageAssetNames.bag,
                    label: 'Total Orders',
                    value: 365,
                  ),
                  CustomTableCell(
                    icon: ImageAssetNames.box,
                    label: 'Out of Stock',
                    value: 500,
                  ),
                ],
              ),
              TableRow(
                children: <Widget>[
                  CustomTableCell(
                    icon: ImageAssetNames.wallet,
                    label: 'Total est. Earnings',
                    value: 11500,
                    isPrice: true,
                  ),
                  CustomTableCell(
                    icon: ImageAssetNames.people,
                    label: 'Customers',
                    value: 200,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24.0),

          /// View ratings report
          Padding(
            padding: padding,
            child: MaterialButton(
              elevation: 0,
              highlightElevation: 0,
              color: AppColors.containerFg,
              padding: const EdgeInsets.all(12.0),
              onPressed: () => notifier.onViewRatingsReport(context),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Row(
                children: <Widget>[
                  SizedBox(width: 4.0),
                  Text(
                    'View ratings report',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13.0,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.chevron_right,
                    color: AppColors.hintColor,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24.0),

          ///
          Container(
            margin: padding,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: AppColors.greyOutline),
            ),
            child: Column(
              children: <Widget>[
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Sales analytics',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    FilterPopupButton(
                        // onPressed: () => notifier.onFilter(context),
                        ),
                  ],
                ),
                const SizedBox(height: 12.0),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: bottomLabelHeight),
                      child: Column(
                        spacing: 24.0,
                        children: List.generate(5, (index) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              const Expanded(
                                child: Divider(
                                  height: .0,
                                  color: AppColors.greyOutline,
                                ),
                              ),
                              SizedBox(
                                height: bottomLabelHeight,
                                child: Center(
                                  child: Text(
                                    '${index * 10}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11.0,
                                      color: Colors.black.withValues(alpha: .6),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).reversed.toList(),
                      ),
                    ),
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 30.0,
                          top: bottomLabelHeight,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: _daysOfTheWeek.map((dayOfTheWeek) {
                            return Column(
                              children: <Widget>[
                                Expanded(
                                  child: SizedBox(
                                    width: 16.0,
                                    child: RotatedBox(
                                      quarterTurns: -1,
                                      child: TweenAnimationBuilder(
                                        duration: const Duration(seconds: 2),
                                        curve: Curves.fastOutSlowIn,
                                        tween: Tween<double>(
                                            begin: 0,
                                            end: Random().nextDouble()),
                                        builder: (context, double value, _) {
                                          return LinearProgressIndicator(
                                            value: value,
                                            backgroundColor: Colors.transparent,
                                            valueColor:
                                                const AlwaysStoppedAnimation<
                                                    Color>(
                                              AppColors.primary,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: bottomLabelHeight,
                                  child: Center(
                                    child: Text(
                                      dayOfTheWeek,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 11.0,
                                        color:
                                            Colors.black.withValues(alpha: .6),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 64.0),
        ],
      ),
    );
  }
}
