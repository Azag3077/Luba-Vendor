import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/assets.dart';
import '../../core/constants/colors.dart';
import '../../core/routers/router.dart';

final paymentPayoutPageProvider =
    AutoDisposeNotifierProvider<_Notifier, _State>(_Notifier.new);

enum PaymentFrequency {
  daily,
  weekly,
  monthly;

  bool get isDaily => this == daily;

  bool get isWeekly => this == weekly;

  bool get isMonthly => this == monthly;
}

class _State {
  const _State({
    this.bankName,
    this.accountNumber = '',
    this.accountName = '',
    this.cashOnDelivery = false,
    this.cardPayment = false,
    this.mobileWallets = false,
    this.paymentFrequency,
  });

  final String? bankName;
  final String accountNumber;
  final String accountName;
  final bool cashOnDelivery;
  final bool cardPayment;
  final bool mobileWallets;
  final PaymentFrequency? paymentFrequency;

  _State copyWith({
    String? bankName,
    String? accountNumber,
    String? accountName,
    bool? cashOnDelivery,
    bool? cardPayment,
    bool? mobileWallets,
    PaymentFrequency? paymentFrequency,
  }) {
    return _State(
      bankName: bankName ?? this.bankName,
      accountNumber: accountNumber ?? this.accountNumber,
      accountName: accountName ?? this.accountName,
      cashOnDelivery: cashOnDelivery ?? this.cashOnDelivery,
      cardPayment: cardPayment ?? this.cardPayment,
      mobileWallets: mobileWallets ?? this.mobileWallets,
      paymentFrequency: paymentFrequency ?? this.paymentFrequency,
    );
  }
}

class _Notifier extends AutoDisposeNotifier<_State> {
  @override
  _State build() => const _State();

  void updateBankName(String? value) => state = state.copyWith(bankName: value);

  void updateAccountNumber(String value) =>
      state = state.copyWith(accountNumber: value);

  void updateAccountName(String value) =>
      state = state.copyWith(accountName: value);

  void toggleCashOnDelivery() =>
      state = state.copyWith(cashOnDelivery: !state.cashOnDelivery);

  void toggleCardPayment() =>
      state = state.copyWith(cardPayment: !state.cardPayment);

  void toggleMobileWallets() =>
      state = state.copyWith(mobileWallets: !state.mobileWallets);

  void updateFrequency(PaymentFrequency paymentFrequency) =>
      state = state.copyWith(paymentFrequency: paymentFrequency);

  void onAddProduct(BuildContext context, GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) return;
  }

  Future<void> onDeleteProduct1(BuildContext context) async {
    final shouldDelete = await showModalBottomSheet<bool?>(
      context: context,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 500),
      ),
      builder: (BuildContext context) {
        return CustomAlertBottomSheet(
          image: ImageAssetNames.error,
          title: 'Delete Product',
          subtitle: 'Are you sure you want to delete this product? '
              'You won’t be able to undo this.',
          actions: <Widget>[
            FilledButton(
              onPressed: () => pop(context, true),
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.red400,
              ),
              child: const Center(child: Text('Delete')),
            ),
          ],
        );
      },
    );

    if (!context.mounted || shouldDelete != true) return;

    // TODO: Do your deleting stuff here
  }

  Future<void> onDeleteProduct(BuildContext context) async {
    final result = await showModalBottomSheet<int?>(
      context: context,
      sheetAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 500),
      ),
      builder: (BuildContext context) {
        return CustomAlertBottomSheet(
          image: ImageAssetNames.success,
          title: 'Product added',
          subtitle: 'Your Product has been added to '
              'the list and is visible to customers',
          actions: <Widget>[
            OutlinedButton(
              onPressed: () => pop(context, 0),
              child: const Center(child: Text('View')),
            ),
            const SizedBox(height: 12.0),
            FilledButton(
              onPressed: () => pop(context, 1),
              child: const Center(child: Text('Add more Product')),
            ),
          ],
        );
      },
    );

    if (!context.mounted || result is! int) return;

    if (result == 0) return pop(context);
    if (result == 1) ref.invalidateSelf();
  }
}

class CustomAlertBottomSheet extends StatelessWidget {
  const CustomAlertBottomSheet({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.actions = const [],
  });

  final String image;
  final String title;
  final String subtitle;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(image),
          const SizedBox(height: 16.0),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 19.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.hintColor,
              fontSize: 16.0,
            ),
          ),
          const SizedBox(height: 16.0),
          ...actions,
        ],
      ),
    );
  }
}
