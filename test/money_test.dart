import 'package:finzee/core/money.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('money uses integer minor units', () {
    expect(Money.fromMajor(10.50).minor, 1050);
    expect((Money.fromMajor(10) + Money.fromMajor(2.25)).format(), contains('12.25'));
    expect(Money(100) - Money(40), const Money(60));
  });
}
