class Order {
  const Order({
    required this.id,
    required this.username,
    required this.location,
    required this.pickupAddress,
    required this.dropOffAddress,
    required this.distanceInKm,
    required this.price,
    required this.status,
    required this.createdOn,
  });

  final int id;
  final String username;
  final String location;
  final String pickupAddress;
  final String dropOffAddress;
  final num distanceInKm;
  final num price;
  final OrderStatus status;
  final DateTime createdOn;
}

enum OrderStatus {
  pending,
  ongoing,
  canceled,
  completed;

  bool get isPending => this == pending;

  bool get isOngoing => this == ongoing;

  bool get isCanceled => this == canceled;

  bool get isCompleted => this == completed;
}
