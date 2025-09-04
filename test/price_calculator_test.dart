import 'package:flutter_test/flutter_test.dart';

class CartLine {
  final double price;
  final int qty;
  const CartLine(this.price, this.qty);
  double get lineTotal => price * qty;
}

double grandTotal(List<CartLine> lines) =>
    lines.fold(0.0, (sum, l) => sum + l.lineTotal);

void main() {
  group('Price calculation', () {
    test('sums price * qty across lines', () {
      final lines = <CartLine>[
        const CartLine(19.99, 2), // 39.98
        const CartLine(49.50, 1), // 49.50
        const CartLine(5.00, 3), // 15.00
      ];
      final total = grandTotal(lines);
      expect(total, closeTo(104.48, 0.0001));
    });

    test('empty list returns 0', () {
      expect(grandTotal(const []), 0.0);
    });

    test('handles floating precision', () {
      final lines = <CartLine>[const CartLine(0.1, 3)]; // 0.3
      expect(grandTotal(lines), closeTo(0.3, 1e-9));
    });
  });
}
