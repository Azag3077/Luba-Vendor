import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/dialogs.dart';
import '../../components/snack_bar.dart';
import '../../core/extensions/num_duration.dart';
import '../../core/routers/app_routes.dart';
import '../../network/api_services/auth.dart';
import '../profile_review/page.dart';
import '../sign_in/page.dart';
import 'page_views/bank_details/provider.dart';
import 'page_views/personal_details/provider.dart';
import 'page_views/terms_and_condition/provider.dart';
import 'page_views/verification_details/provider.dart';

final signUpPageProvider =
    AutoDisposeNotifierProvider<_Notifier, int>(_Notifier.new);

class _Notifier extends AutoDisposeNotifier<int> {
  late final PageController _pageController;
  late final GlobalKey<FormState> _personalDetailsFormKey;
  late final GlobalKey<FormState> _businessDetailsFormKey;
  late final GlobalKey<FormState> _verificationDetailsFormKey;

  @override
  int build() {
    ref.onDispose(_onDispose);
    return 0;
  }

  void _onDispose() {
    ref.invalidate(personalDetailsPageViewProvider);
    ref.invalidate(verificationDetailsPageViewProvider);
    ref.invalidate(bankDetailsPageViewProvider);
    ref.invalidate(termsAndConditionPageViewProvider);
  }

  void initialize({
    required PageController pageController,
    required GlobalKey<FormState> personalDetailsFormKey,
    required GlobalKey<FormState> businessDetailsFormKey,
    required GlobalKey<FormState> verificationDetailsFormKey,
  }) {
    _pageController = pageController;
    _personalDetailsFormKey = personalDetailsFormKey;
    _businessDetailsFormKey = businessDetailsFormKey;
    _verificationDetailsFormKey = verificationDetailsFormKey;
  }

  void onPopInvokedWithResult(bool didPop, bool? result) {
    if (!didPop) _navigateToNextPageView(false);
  }

  void updatePageIndex(int index) => state = index;

  Future<void> onContinue(BuildContext context) async {
    late final GlobalKey<FormState> formKey;
    if (state == 0) formKey = _personalDetailsFormKey;
    if (state == 1) formKey = _businessDetailsFormKey;
    if (state == 2) formKey = _verificationDetailsFormKey;

    formKey.currentState?.reset();

    await 200.ms.delayed;
    if (!(formKey.currentState?.validate() ?? true)) return;

    if (state != 2) {
      _navigateToNextPageView(true);
    } else if (context.mounted) {
      if (context.mounted) _registerUser(context);
    }
  }

  void _navigateToNextPageView(bool forward) {
    final duration = 200.ms;
    const curve = Curves.linear;

    if (forward) {
      _pageController.nextPage(duration: duration, curve: curve);
    } else {
      _pageController.previousPage(duration: duration, curve: curve);
    }
  }

  Future<void> _registerUser(BuildContext context) async {
    showLoadingDialog(context);

    final personalDetails = ref.read(personalDetailsPageViewProvider);

    final result = await AuthService.registerUser(
      email: personalDetails.email,
      phone: personalDetails.phone,
      country: personalDetails.country!.name,
      password: '_password',
    );

    if (!context.mounted) return;

    pop(context);

    if (result.data!) return _handleRegSuccess(context);

    showSnackBar(
      context: context,
      title: result.error!.title,
      subtitle: result.error!.message,
      type: SnackBarType.error,
    );
  }

  Future<void> _handleRegSuccess(BuildContext context) async {
    showSnackBar(
      context: context,
      title: 'Successful',
      subtitle: 'Registration successful!!!',
      type: SnackBarType.success,
    );

    pushNamedAndRemoveUntil(
      context,
      ProfileReviewPage.routeName,
      until: SignInPage.routeName,
    );
  }

  void onSignIn(BuildContext context) =>
      pushReplacementNamed(context, SignInPage.routeName);
}
