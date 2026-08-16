import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/money.dart';
import '../../domain/entities.dart';

class TransactionRow extends StatelessWidget {
  const TransactionRow({super.key, required this.tx, this.categoryName});

  final FinanceTransaction tx;
  final String? categoryName;

  @override
  Widget build(BuildContext context) {
    final expenseLike = tx.type == TransactionType.expense ||
        tx.type == TransactionType.saving ||
        tx.type == TransactionType.investment;
    final color = tx.type == TransactionType.income
        ? FinzeeColors.income
        : expenseLike
            ? FinzeeColors.expense
            : FinzeeColors.info;
    final prefix = tx.type == TransactionType.income
        ? '+'
        : tx.type == TransactionType.transfer
            ? ''
            : '-';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(_icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.note?.isNotEmpty == true
                      ? tx.note!
                      : (categoryName ?? tx.type.name),
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  '${tx.date.day}/${tx.date.month}/${tx.date.year} · ${tx.type.name}',
                  style: const TextStyle(
                    color: FinzeeColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$prefix${tx.amount.format()}',
            style: TextStyle(color: color, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  IconData get _icon => switch (tx.type) {
        TransactionType.income => Icons.south_west,
        TransactionType.expense => Icons.north_east,
        TransactionType.transfer => Icons.swap_horiz,
        TransactionType.saving => Icons.savings_outlined,
        TransactionType.investment => Icons.show_chart,
      };
}

class AmountField extends StatelessWidget {
  const AmountField({super.key, required this.controller, this.label = 'Amount'});

  final TextEditingController controller;
  final String label;

  Money? get money {
    final v = double.tryParse(controller.text.replaceAll(',', ''));
    if (v == null) return null;
    return Money.fromMajor(v);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label, prefixText: '₹ '),
    );
  }
}
