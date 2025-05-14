import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/place_holders.dart';
import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../core/extensions/datetime.dart';
import 'provider.dart';

class RatingPage extends ConsumerWidget {
  const RatingPage({super.key});

  static const routeName = '/rating';

  Widget _buildDivider() {
    return const Divider(
      color: AppColors.greyOutline,
      indent: 16.0,
      endIndent: 16.0,
      height: 0,
    );
  }

  Widget _buildChip({
    required BuildContext context,
    required int value,
    required int active,
    int? count,
    required ValueChanged<int> onPressed,
  }) {
    final isActive = value == active;
    final isAll = value == 0;

    return Padding(
      padding: EdgeInsets.only(left: isAll ? 0.0 : 8.0),
      child: ActionChip(
        onPressed: () => onPressed(value),
        shape: const StadiumBorder(),
        backgroundColor: isActive
            ? AppColors.primary
            : Theme.of(context).scaffoldBackgroundColor,
        label: Row(
          spacing: 4.0,
          children: <Widget>[
            Text(
              isAll ? 'All' : '$value rating',
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.primary,
                fontWeight: FontWeight.w500,
                fontSize: 11.0,
              ),
            ),
            if (!isAll) ...[
              const Icon(
                Icons.star,
                size: 14.0,
                color: AppColors.yellow500,
              ),
              Text(
                '($count)',
                style: TextStyle(
                  color: isActive ? AppColors.greyOutline : AppColors.secText,
                  fontWeight: FontWeight.w500,
                  fontSize: 11.0,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final active = ref.watch(ratingPageProvider);
    final notifier = ref.read(ratingPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Rating')),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(18.0),
            color: const Color(0xFF252A22),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(ImageAssetNames.award1),
                Expanded(
                  child: Column(
                    spacing: 8.0,
                    children: <Widget>[
                      const Text(
                        '4 star rating',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyOutline,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(4, (_) {
                          return const Icon(
                            Icons.star,
                            color: AppColors.yellow500,
                          );
                        }),
                      ),
                      const Text(
                        '(20 reviews)',
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyOutline,
                        ),
                      ),
                    ],
                  ),
                ),
                Image.asset(ImageAssetNames.award5),
              ],
            ),
          ),
          SizedBox(
            height: 64.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: List.generate(6, (index) {
                return _buildChip(
                  context: context,
                  value: index,
                  active: active,
                  count: 232,
                  onPressed: notifier.updateState,
                );
              }),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: ListView.separated(
                itemCount: 32,
                separatorBuilder: (context, int index) => _buildDivider(),
                itemBuilder: (context, int index) {
                  return MaterialButton(
                    onPressed: () {},
                    elevation: 0,
                    highlightElevation: 0,
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      spacing: 8.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          spacing: 8.0,
                          children: <Widget>[
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: const ShapeDecoration(
                                shape: StadiumBorder(
                                  side: BorderSide(
                                    color: AppColors.greyOutline,
                                  ),
                                ),
                              ),
                              child: const ImageLoader(
                                '',
                                width: 38.0,
                                height: 38.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text(
                                    'Clement John',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    DateTime.now().toStr(),
                                    style: const TextStyle(
                                      fontSize: 11.0,
                                      color: Color(0xFF666666),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              decoration: const ShapeDecoration(
                                color: AppColors.green50,
                                shape: StadiumBorder(),
                              ),
                              child: const Row(
                                spacing: 4.0,
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    size: 14.0,
                                    color: AppColors.yellow500,
                                  ),
                                  Text(
                                    '4 star rating',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primary,
                                      fontSize: 11.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'This delivery was fast and food was so '
                          'delicious and the rider ws very fast with caution',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: AppColors.hintColor,
                            fontSize: 13.0,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
