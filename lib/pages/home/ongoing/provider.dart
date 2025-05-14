import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/extensions/num_duration.dart';
import '../../../models/order.dart';

final uselessProvider = StateProvider<bool>((_) => false);

final ongoingOrderFutureProvider = FutureProvider<List<Order>>((ref) async {
  await 1.5.seconds.delayed;
  final useless = ref.watch(uselessProvider);
  return List.generate(useless ? 1 : 0, (index) {
    return Order(
      id: 49065 + index,
      username: 'Iya Moria',
      location: r'UNILAG',
      pickupAddress: r'Shoprite Ikeja City mall, Ikeja City mall, awolowo',
      dropOffAddress: r'Yaba road, idi araba street',
      distanceInKm: 2.2,
      price: 1500,
      status: OrderStatus.ongoing,
      createdOn: DateTime.now().subtract(const Duration(days: 3)),
    );
  });
});
