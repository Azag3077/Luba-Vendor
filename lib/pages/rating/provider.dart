import 'package:flutter_riverpod/flutter_riverpod.dart';

final ratingPageProvider = NotifierProvider<_Notifier, int>(_Notifier.new);

class _Notifier extends Notifier<int> {
  @override
  int build() => 0;

  void updateState(int value) => state = value;
}
