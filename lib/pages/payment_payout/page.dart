import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/buttons.dart';
import '../../components/text_fields.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/constants.dart';
import '../../core/extensions/string.dart';
import '../../core/validators.dart';
import 'provider.dart';

class PaymentPayoutPage extends ConsumerWidget {
  const PaymentPayoutPage({super.key});

  static const routeName = '/payment-payout';
  static final _formKey = GlobalKey<FormState>();

  Widget _buildLabelHintText({
    required String labelText,
    required String hintText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 16.0),
        Text(
          labelText,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: 14.0,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          hintText,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            color: AppColors.text,
            fontSize: 12.0,
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  Widget _buildSwitchListTile({
    required String title,
    String? subtitle,
    required bool value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 13.0,
          fontWeight: FontWeight.w600,
          color: AppColors.text,
        ),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
                color: AppColors.text,
              ),
            ),
      trailing: Transform.scale(
        scale: .7,
        child: Switch(
          value: value,
          onChanged: (_) {},
        ),
      ),
      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
      contentPadding: const EdgeInsets.only(left: 12.0, right: 4.0),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(paymentPayoutPageProvider);
    final notifier = ref.read(paymentPayoutPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Payment & payout')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                children: <Widget>[
                  _buildLabelHintText(
                    labelText: 'Bank Account Details',
                    hintText: 'input your bank details for payment.',
                  ),
                  SelectionButton<String>(
                    labelText: 'Select Bank',
                    hintText: 'Select bank name',
                    initialValue: state.bankName,
                    bottomSheetItems: List.generate(23, (i) => 'Bank $i'),
                    textBuilder: (type) => type,
                    validator: Validator.name,
                    onSaved: notifier.updateBankName,
                    filled: false,
                  ),
                  CustomTextField(
                    labelText: 'Account Number',
                    hintText: 'Enter account number',
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: Validator.validateAccountNumber,
                    textInputAction: TextInputAction.next,
                    filled: false,
                    maxLength: 10,
                    initialValue: state.accountNumber,
                    onChanged: notifier.updateAccountNumber,
                  ),
                  CustomTextField(
                    labelText: 'Account Holder Name',
                    hintText: 'Enter account name',
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.words,
                    validator: Validator.name,
                    textInputAction: TextInputAction.next,
                    filled: false,
                    initialValue: state.accountName,
                    onChanged: notifier.updateAccountName,
                  ),
                  _buildLabelHintText(
                    labelText: 'Payment Methods Accepted',
                    hintText: 'Choose how customers can pay you.',
                  ),
                  _Container(
                    child: Column(
                      children: <Widget>[
                        _buildSwitchListTile(
                          title: 'Cash on Delivery',
                          value: state.cashOnDelivery,
                          onTap: notifier.toggleCashOnDelivery,
                        ),
                        _buildSwitchListTile(
                          title: 'Card Payments',
                          value: state.cardPayment,
                          onTap: notifier.toggleCardPayment,
                        ),
                        _buildSwitchListTile(
                          title: 'Mobile wallets',
                          subtitle: '(Apple Pay, Google Pay, Paypal, etc.)',
                          value: state.mobileWallets,
                          onTap: notifier.toggleMobileWallets,
                        ),
                      ],
                    ),
                  ),
                  _buildLabelHintText(
                    labelText: 'Payout Frequency',
                    hintText: 'Set how often you want to receive payouts.',
                  ),
                  _Container(
                    child: Column(
                      children: PaymentFrequency.values.map((frequency) {
                        return ListTile(
                          onTap: () => notifier.updateFrequency(frequency),
                          leading: Radio(
                            value: state.paymentFrequency == frequency,
                            groupValue: true,
                            onChanged: (_) {},
                          ),
                          title: Text(
                            frequency.name.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.text,
                              fontSize: 13.0,
                            ),
                          ),
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          contentPadding: const EdgeInsets.only(left: 12.0, right: 4.0),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: FilledButton(
              onPressed: () => notifier.onAddProduct(context, _formKey),
              child: const Center(
                child: Text('Save'),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class _Container extends StatelessWidget {
  const _Container({
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kTextFieldRadius),
        border: Border.all(
          color: AppColors.borderColor,
          width: 1.5,
        ),
      ),
      child: child,
    );
  }
}
