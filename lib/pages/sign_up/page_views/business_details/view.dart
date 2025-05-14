import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../components/buttons.dart';
import '../../../../../components/phone_number_field_prefix_button.dart';
import '../../../../../components/textfields.dart';
import '../../../../../core/validators.dart';
import 'provider.dart';

class BusinessDetailsPageView extends ConsumerWidget {
  const BusinessDetailsPageView(this.formKey, {super.key});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(businessDetailsPageViewProvider);
    final notifier = ref.read(businessDetailsPageViewProvider.notifier);

    final textTheme = Theme.of(context).textTheme;

    return AutofillGroup(
      child: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            Text('Business Details', style: textTheme.headlineMedium),
            const SizedBox(height: 24.0),
            CustomTextField(
              labelText: 'Business Name',
              initialValue: state.businessName,
              onChanged: notifier.updateBusinessName,
              hintText: 'Enter business name',
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.words,
              validator: Validator.name,
            ),
            SelectionButton<String>(
              labelText: 'Business type',
              hintText: 'Select business type',
              initialValue: state.businessType,
              bottomSheetItems: List.generate(23, (i) => 'Business type $i'),
              textBuilder: (type) => type,
              validator: Validator.name,
              onSaved: notifier.updateBusinessType,
            ),
            CustomTextField(
              labelText: 'Business Address',
              initialValue: state.businessAddress,
              onChanged: notifier.updateBusinessAddress,
              hintText: 'Enter business address',
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.streetAddress,
              textCapitalization: TextCapitalization.words,
              validator: Validator.name,
            ),
            CustomTextField(
              labelText: 'Phone Number',
              initialValue: state.phone,
              onChanged: notifier.onPhoneChanged,
              hintText: 'Enter your phone number',
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputAction: TextInputAction.next,
              validator: Validator.validatePhoneNumber,
              prefixIcon: PhoneNumberFieldPrefixButton(
                country: state.country,
                onCodeTap: () => notifier.onCodeTap(context),
              ),
            ),
            CustomTextField(
              labelText: 'City',
              initialValue: state.city,
              onChanged: notifier.updateCity,
              hintText: 'Enter your city',
              keyboardType: TextInputType.streetAddress,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              validator: Validator.name,
            ),
            CustomTextField(
              labelText: 'CAC Registration Number',
              initialValue: state.regNo,
              onChanged: notifier.updateRegNo,
              hintText: 'Enter CAC reg. number',
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textInputAction: TextInputAction.next,
              validator: Validator.name,
            ),
          ],
        ),
      ),
    );
  }
}
