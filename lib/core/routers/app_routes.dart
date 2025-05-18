import 'package:flutter/material.dart';

import '../../pages/add_bank/page.dart';
import '../../pages/boost_earnings/page.dart';
import '../../pages/dashboard/page.dart';
import '../../pages/delivery_complete/page.dart';
import '../../pages/delivery_issues/page.dart';
import '../../pages/forgot_password/page.dart';
import '../../pages/notifications/page.dart';
import '../../pages/order_details/page.dart';
import '../../pages/privacy_policy/page.dart';
import '../../pages/product/page.dart';
import '../../pages/products/page.dart';
import '../../pages/profile/page.dart';
import '../../pages/profile_review/page.dart';
import '../../pages/rating/page.dart';
import '../../pages/report/page.dart';
import '../../pages/payment_payout/page.dart';
import '../../pages/report_details/page.dart';
import '../../pages/report_submitted/page.dart';
import '../../pages/reset_password/page.dart';
import '../../pages/reset_pin/page.dart';
import '../../pages/settings/page.dart';
import '../../pages/sign_in/page.dart';
import '../../pages/sign_up/page.dart';
import '../../pages/splash_screen/page.dart';
import '../../pages/successful/page.dart';
import '../../pages/verify_otp/page.dart';
import '../../pages/withdraw_earnings/page.dart';

export 'router.dart';

T _getArgs<T>(BuildContext context) =>
    ModalRoute.of(context)!.settings.arguments as T;

final appRoutes = <String, WidgetBuilder>{
  '/': (context) => const SplashScreen(),
  // '/': (context) => const DashboardPage(),
  SignInPage.routeName: (_) => SignInPage(),
  SignUpPage.routeName: (_) => const SignUpPage(),
  ProfileReviewPage.routeName: (_) => const ProfileReviewPage(),
  VerifyOtpPage.routeName: (context) => VerifyOtpPage(_getArgs(context)),
  ForgotPasswordPage.routeName: (_) => ForgotPasswordPage(),
  ResetPasswordPage.routeName: (_) => ResetPasswordPage(),
  SuccessfulPage.routeName: (context) => SuccessfulPage(_getArgs(context)),
  DashboardPage.routeName: (_) => const DashboardPage(),
  NotificationsPage.routeName: (_) => const NotificationsPage(),
  OrderDetailsPage.routeName: (context) => OrderDetailsPage(_getArgs(context)),
  DeliveryCompletePage.routeName: (context) =>
      DeliveryCompletePage(_getArgs(context)),
  ReportPage.routeName: (_) => const ReportPage(),
  ReportDetailsPage.routeName: (context) =>
      ReportDetailsPage(_getArgs(context)),
  ReportSubmittedPage.routeName: (_) => const ReportSubmittedPage(),
  DeliveryIssuesPage.routeName: (_) => const DeliveryIssuesPage(),
  ProductsPage.routeName: (context) => const ProductsPage(),
  ProductPage.routeName: (context) => ProductPage(product: _getArgs(context)),
  WithdrawEarningsPage.routeName: (_) => const WithdrawEarningsPage(),
  AddBankPage.routeName: (_) => const AddBankPage(),
  SettingsPage.routeName: (_) => const SettingsPage(),
  RatingPage.routeName: (_) => const RatingPage(),
  BoostEarningsPage.routeName: (_) => const BoostEarningsPage(),
  ResetPinPage.routeName: (_) => const ResetPinPage(),
  PrivacyPolicyPage.routeName: (_) => const PrivacyPolicyPage(),
  ProfilePage.routeName: (_) => const ProfilePage(),
  PaymentPayoutPage.routeName: (_) => const PaymentPayoutPage(),

  ///
  BlankPage.routeName: (context) => const BlankPage(),
};

class BlankPage extends StatelessWidget {
  const BlankPage({super.key});

  static const routeName = '/blank';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Placeholder(
        child: Center(
          child: Text('Coming soon'),
        ),
      ),
    );
  }
}
