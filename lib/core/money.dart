import 'package:intl/intl.dart';

/// Integer minor units (paise) — never use floating point for money.
class Money {
  const Money(this.minor);

  final int minor;

  factory Money.fromMajor(num major) =>
      Money((major * 100).round());

  double get major => minor / 100.0;

  Money operator +(Money other) => Money(minor + other.minor);
  Money operator -(Money other) => Money(minor - other.minor);
  Money operator -() => Money(-minor);

  bool get isNegative => minor < 0;
  bool get isZero => minor == 0;

  String format({String symbol = '₹'}) {
    final n = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: 2,
      locale: 'en_IN',
    );
    return n.format(major);
  }

  @override
  bool operator ==(Object other) => other is Money && other.minor == minor;

  @override
  int get hashCode => minor.hashCode;

  @override
  String toString() => format();
}
