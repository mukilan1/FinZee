import 'package:flutter/material.dart';

import '../../app/theme.dart';

/// Consistent vertical rhythm across forms, lists, and cards.
abstract final class FinzeeSpacing {
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 20;
  static const double xl = 24;
  static const double xxl = 32;
}

Future<T?> showFinzeeBottomSheet<T>(
  BuildContext context, {
  required Widget child,
  bool isScrollControlled = true,
}) {
  final palette = context.finzee;
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: isScrollControlled,
    backgroundColor: palette.surface,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (ctx) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
      child: child,
    ),
  );
}

/// Shows a themed dialog. Always use [dialogContext] from the builder for
/// [Navigator.pop] inside dialog actions — never the page context.
Future<T?> showFinzeeDialog<T>(
  BuildContext context, {
  required Widget Function(BuildContext dialogContext) builder,
}) {
  return showDialog<T>(
    context: context,
    builder: (dialogContext) => builder(dialogContext),
  );
}

class FinzeeSheetHeader extends StatelessWidget {
  const FinzeeSheetHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final palette = context.finzee;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: FinzeeSpacing.md),
            decoration: BoxDecoration(
              color: palette.border,
              borderRadius: BorderRadius.circular(99),
            ),
          ),
        ),
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        if (subtitle != null) ...[
          const SizedBox(height: FinzeeSpacing.xs),
          Text(subtitle!, style: TextStyle(color: palette.textSecondary)),
        ],
        const SizedBox(height: FinzeeSpacing.md),
      ],
    );
  }
}

class FinzeeFormDialog extends StatelessWidget {
  const FinzeeFormDialog({
    super.key,
    required this.title,
    required this.fields,
    required this.actions,
  });

  final String title;
  final List<Widget> fields;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < fields.length; i++) ...[
              if (i > 0) const SizedBox(height: FinzeeSpacing.md),
              fields[i],
            ],
          ],
        ),
      ),
      actions: actions,
    );
  }
}

class FinzeeSectionLabel extends StatelessWidget {
  const FinzeeSectionLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: FinzeeSpacing.xs),
      child: Text(
        text,
        style: TextStyle(
          color: context.finzee.textSecondary,
          fontWeight: FontWeight.w600,
          fontSize: 13,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}

/// Spaced form fields for dialogs and sheets.
class FinzeeFormFields extends StatelessWidget {
  const FinzeeFormFields({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(height: FinzeeSpacing.md),
          children[i],
        ],
      ],
    );
  }
}
