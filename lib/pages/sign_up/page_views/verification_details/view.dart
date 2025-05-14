import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/validators.dart';
import '../../components/image_picker.dart';
import 'provider.dart';

class VerificationDetailsPageView extends ConsumerWidget {
  const VerificationDetailsPageView(this.formKey, {super.key});

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verificationDetailsPageViewProvider);
    final notifier = ref.read(verificationDetailsPageViewProvider.notifier);

    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Business Verification Details',
                style: textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 24.0),
            ImagePickerContainer(
              imagePath: state.license,
              icon: ImageAssetNames.documentUpload,
              labelText: 'Upload your CAC certificate',
              titleText: 'Click to upload file',
              subtitleText: 'We support PDFs, JPGs and PNGs under 10mb.',
              onSaved: notifier.updateLicense,
              validator: Validator.name,
            ),
          ],
        ),
      ),
    );
  }
}
