import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/textfields.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/constants.dart';
import '../../core/validators.dart';
import '../../models/product.dart';
import '../sign_up/components/image_picker.dart';
import 'provider.dart';

class ProductPage extends ConsumerWidget {
  const ProductPage({
    this.product,
    super.key,
  });

  final Product? product;

  static const routeName = '/product';
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productPageProvider);
    final notifier = ref.read(productPageProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product == null ? 'Add Product' : 'Product Details',
        ),
      ),
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
                  const ImagePickerContainer(
                    labelText: 'Upload product image',
                    height: 140,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    labelText: 'Product category',
                    hintText: 'Enter a category',
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    validator: Validator.name,
                    textInputAction: TextInputAction.next,
                    onChanged: notifier.updateCategory,
                  ),
                  CustomTextField(
                    labelText: 'Product title',
                    hintText: 'Enter a title',
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.text,
                    validator: Validator.name,
                    textInputAction: TextInputAction.next,
                    onChanged: notifier.updateTitle,
                  ),
                  Row(
                    spacing: 12.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: CustomTextField(
                          labelText: 'Product price',
                          hintText: 'Enter a price',
                          keyboardType: TextInputType.number,
                          validator: Validator.name,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [NumberInputFormatter()],
                          onChanged: notifier.updatePrice,
                        ),
                      ),
                      const Expanded(
                        child: CustomTextField(
                          labelText: 'Preparation time',
                        ),
                      ),
                    ],
                  ),
                  CustomTextField(
                    labelText: 'Discount price (optional)',
                    hintText: 'Enter an optional discount price',
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    inputFormatters: [NumberInputFormatter()],
                    onChanged: notifier.updateDiscount,
                  ),
                  CustomTextField(
                    labelText: 'Description',
                    hintText: 'Please enter product description',
                    textCapitalization: TextCapitalization.sentences,
                    keyboardType: TextInputType.multiline,
                    validator: Validator.name,
                    maxLines: 5,
                    onChanged: notifier.updateDesc,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.textFieldBg,
                      borderRadius: BorderRadius.circular(kTextFieldRadius),
                      border: Border.all(
                        color: AppColors.borderColor,
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Mark product in stock',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.0,
                          ),
                        ),
                        Transform.scale(
                          scale: .8,
                          child: Switch(
                              value: state.isInStock,
                              onChanged: notifier.updateIsInStock),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                      label: const Text('Add option'),
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
            child: Column(
              spacing: 12.0,
              children: <Widget>[
                FilledButton(
                  onPressed: () => notifier.onAddProduct(context, _formKey),
                  child: Center(
                    child:
                        Text(product == null ? 'Add product' : 'Save product'),
                  ),
                ),
                if (product != null)
                  OutlinedButton(
                    onPressed: () => notifier.onDeleteProduct(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                    ),
                    child: const Center(child: Text('Delete product')),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  DashedLinePainter({
    this.color = const Color(0xFFB0B0B0),
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
