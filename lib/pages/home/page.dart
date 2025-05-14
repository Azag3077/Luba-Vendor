import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/button.dart';
import 'ongoing/page_view.dart';
import 'pending/page_view.dart';
import 'provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(homePageProvider.notifier);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: ActionButton(
            username: 'Dummy User',
            imageUrl: '',
            onPressed: () => notifier.onUserProfile(context),
          ),
          actions: <Widget>[
            const Text('Online'),
            const SizedBox(width: 4.0),
            Switch(
              value: true,
              onChanged: (_) {},
            ),
            const SizedBox(width: 16.0),
          ],
        ),
        body: const Column(
          children: <Widget>[
            TabBar(
              tabs: <Widget>[
                Tab(text: 'Pending'),
                Tab(text: 'Ongoing'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  PendingPageView(),
                  OngoingPageView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
