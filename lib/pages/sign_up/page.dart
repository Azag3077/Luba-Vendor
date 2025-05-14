import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'components/page_indicator.dart';
import 'page_views/business_details/view.dart';
import 'page_views/personal_details/view.dart';
import 'page_views/verification_details/view.dart';
import 'provider.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  static const routeName = '/sign-up';

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _pageController = PageController();
  final _personalDetailsFormKey = GlobalKey<FormState>();
  final _businessDetailsFormKey = GlobalKey<FormState>();
  final _verificationDetailsFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(signUpPageProvider.notifier);
      notifier.initialize(
        pageController: _pageController,
        personalDetailsFormKey: _personalDetailsFormKey,
        businessDetailsFormKey: _businessDetailsFormKey,
        verificationDetailsFormKey: _verificationDetailsFormKey,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageIndex = ref.watch(signUpPageProvider);
    final notifier = ref.read(signUpPageProvider.notifier);

    return PopScope(
      canPop: pageIndex == 0,
      onPopInvokedWithResult: notifier.onPopInvokedWithResult,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: PageIndicator(
              length: 3,
              currentIndex: pageIndex,
            ),
          ),
        ),
        body: Column(
          spacing: 8.0,
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: notifier.updatePageIndex,
                physics: const NeverScrollableScrollPhysics(),
                children: <Widget>[
                  PersonalDetailsPageView(_personalDetailsFormKey),
                  BusinessDetailsPageView(_businessDetailsFormKey),
                  VerificationDetailsPageView(_verificationDetailsFormKey),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FilledButton(
                onPressed: () => notifier.onContinue(context),
                child: const Center(child: Text('Continue')),
              ),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
