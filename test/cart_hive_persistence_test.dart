import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

// Minimal in-test CartItem and Controller mirroring app’s logic and models.
class CartItem {
  final int id;
  final String title;
  final double price;
  final String image;
  final int quantity;
  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
  });
  CartItem copyWith({int? quantity}) => CartItem(
    id: id,
    title: title,
    price: price,
    image: image,
    quantity: quantity ?? this.quantity,
  );
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'price': price,
    'image': image,
    'quantity': quantity,
  };
  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
    id: (json['id'] as num).toInt(),
    title: (json['title'] as String?) ?? '',
    price: (json['price'] as num).toDouble(),
    image: (json['image'] as String?) ?? '',
    quantity: (json['quantity'] as num?)?.toInt() ?? 1,
  );
}

//similar logic as in main application
class CartControllerHive {
  static const _boxName = 'cartBox';
  static const _keyItems = 'items';
  late Box _box;
  List<CartItem> items = [];

  // initializing the hive database
  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
    await load();
  }

  // loading at the first time
  Future<void> load() async {
    final data = _box.get(_keyItems);
    if (data is List) {
      items = data
          .map((e) => CartItem.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } else {
      items = [];
    }
  }

  // after any changes storing it again to hive
  Future<void> _persist() async {
    await _box.put(_keyItems, items.map((e) => e.toJson()).toList());
  }

  // storing first item in the cart fake database
  Future<void> seed(CartItem item) async {
    items.removeWhere((e) => e.id == item.id);
    items.add(item);
    await _persist();
  }

  // function to increse the quantity one by one
  Future<void> increment(int id) async {
    final idx = items.indexWhere((e) => e.id == id);
    if (idx == -1) return;
    final current = items[idx];
    if (current.quantity >= 10) return;
    items[idx] = current.copyWith(quantity: current.quantity + 1);
    await _persist();
  }
}

void main() {
  group('Hive cart persistence', () {
    late Directory tempHiveDir;

    setUp(() async {
      // Using a VM-safe temp directory (no platform channels)
      tempHiveDir = Directory.systemTemp.createTempSync('hive_test_');
      Hive.init(tempHiveDir.path);
    });

    tearDown(() async {
      // Clean Hive files and temp dir
      await Hive.deleteFromDisk();
      if (tempHiveDir.existsSync()) {
        tempHiveDir.deleteSync(recursive: true);
      }
    });

    test(
      'increment persists quantity for a product id and survives reload',
      () async {
        final c1 = CartControllerHive();
        await c1.init();

        // Seed with one item qty=1
        final item = CartItem(
          id: 101,
          title: 'Test',
          price: 9.99,
          image: 'img',
          quantity: 1,
        );
        await c1.seed(item);

        // Increment -> qty should be 2
        await c1.increment(101);
        expect(c1.items.firstWhere((e) => e.id == 101).quantity, 2);

        // Simulate new app session: reopen controller and load from Hive
        final c2 = CartControllerHive();
        await c2.init();
        expect(c2.items.firstWhere((e) => e.id == 101).quantity, 2);
      },
    );
  });
}
