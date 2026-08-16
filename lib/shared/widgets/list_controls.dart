import 'package:flutter/material.dart';

import '../../app/theme.dart';

class ListControls extends StatelessWidget {
  const ListControls({
    super.key,
    required this.query,
    required this.onQuery,
    this.hint = 'Search',
    this.filters = const [],
    this.selectedFilter,
    this.onFilter,
    this.sorts = const [],
    this.sortId,
    this.onSort,
  });

  final String query;
  final ValueChanged<String> onQuery;
  final String hint;
  final List<String> filters;
  final String? selectedFilter;
  final ValueChanged<String?>? onFilter;
  final List<(String id, String label)> sorts;
  final String? sortId;
  final ValueChanged<String>? onSort;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            hintText: hint,
          ),
          onChanged: onQuery,
        ),
        if (filters.isNotEmpty) ...[
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: const Text('All'),
                    selected: selectedFilter == null,
                    onSelected: (_) => onFilter?.call(null),
                  ),
                ),
                ...filters.map(
                  (f) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(f),
                      selected: selectedFilter == f,
                      onSelected: (_) => onFilter?.call(f),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        if (sorts.isNotEmpty) ...[
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: DropdownButton<String>(
              value: sortId ?? sorts.first.$1,
              underline: const SizedBox.shrink(),
              items: sorts
                  .map((s) => DropdownMenuItem(value: s.$1, child: Text('Sort: ${s.$2}')))
                  .toList(),
              onChanged: (v) {
                if (v != null) onSort?.call(v);
              },
            ),
          ),
        ],
      ],
    );
  }
}

Future<DateTime?> pickTimeline(
  BuildContext context, {
  DateTime? initial,
  DateTime? firstDate,
  DateTime? lastDate,
}) {
  final now = DateTime.now();
  return showDatePicker(
    context: context,
    initialDate: initial ?? now,
    firstDate: firstDate ?? DateTime(now.year - 15),
    lastDate: lastDate ?? DateTime(now.year + 15),
  );
}

class TimelineTile extends StatelessWidget {
  const TimelineTile({
    super.key,
    required this.label,
    required this.date,
    required this.onPick,
  });

  final String label;
  final DateTime date;
  final VoidCallback onPick;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      subtitle: Text('${date.day}/${date.month}/${date.year}'),
      trailing: const Icon(Icons.event),
      onTap: onPick,
    );
  }
}

Future<bool> confirmDelete(
  BuildContext context, {
  required String title,
  String body = 'This cannot be undone. The record is removed from this device only.',
  String confirmLabel = 'Delete',
}) async {
  final ok = await showDialog<bool>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: FinzeeColors.expense),
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return ok ?? false;
}

Future<void> showErasedConfirmation(
  BuildContext context, {
  required String title,
  String body = 'This data has been erased from FinZee on this device.',
  bool success = true,
}) async {
  if (!context.mounted) return;
  await showDialog<void>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      title: Row(
        children: [
          Icon(
            success ? Icons.check_circle_outline : Icons.error_outline,
            color: success ? FinzeeColors.income : FinzeeColors.expense,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(title)),
        ],
      ),
      content: Text(body),
      actions: [
        FilledButton(onPressed: () => Navigator.pop(ctx), child: const Text('OK')),
      ],
    ),
  );
}

Future<bool> confirmAndErase(
  BuildContext context, {
  required String title,
  String body = 'This cannot be undone. The record is removed from this device only.',
  String confirmLabel = 'Delete',
  required Future<bool> Function() erase,
  String doneTitle = 'Erased',
  String doneBody = 'This data has been erased from FinZee on this device.',
  String? Function()? failBody,
}) async {
  final ok = await confirmDelete(context, title: title, body: body, confirmLabel: confirmLabel);
  if (!ok || !context.mounted) return false;
  final success = await erase();
  if (!context.mounted) return success;
  await showErasedConfirmation(
    context,
    title: success ? doneTitle : 'Not deleted',
    body: success ? doneBody : (failBody?.call() ?? 'Nothing was erased.'),
    success: success,
  );
  return success;
}

Future<void> confirmEraseFromEditor({
  required BuildContext pageContext,
  required BuildContext dialogContext,
  required String title,
  required Future<bool> Function() erase,
  String doneTitle = 'Erased',
  String doneBody = 'This data has been erased from FinZee on this device.',
  String? Function()? failBody,
}) async {
  final ok = await confirmDelete(dialogContext, title: title);
  if (!ok) return;
  final success = await erase();
  if (success && dialogContext.mounted) Navigator.pop(dialogContext, false);
  if (!pageContext.mounted) return;
  await showErasedConfirmation(
    pageContext,
    title: success ? doneTitle : 'Not deleted',
    body: success ? doneBody : (failBody?.call() ?? 'Nothing was erased.'),
    success: success,
  );
}

class WipeDraft {
  const WipeDraft({required this.phrase, this.pin});
  final String phrase;
  final String? pin;
}

Future<WipeDraft?> collectWipeDraft(
  BuildContext context, {
  required bool pinRequired,
}) async {
  final first = await showDialog<bool>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      title: const Text('Delete all FinZee data?'),
      content: const Text(
        'This permanently wipes accounts, transactions, plans, goals, and settings on this device.',
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: FinzeeColors.expense),
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Continue'),
        ),
      ],
    ),
  );
  if (first != true || !context.mounted) return null;

  final phrase = TextEditingController();
  final pin = TextEditingController();
  final second = await showDialog<bool>(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (ctx) => AlertDialog(
      title: const Text('Type DELETE to confirm'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Second warning: type DELETE in capital letters.'),
          const SizedBox(height: 12),
          TextField(
            controller: phrase,
            decoration: const InputDecoration(labelText: 'Type DELETE'),
          ),
          if (pinRequired) ...[
            const SizedBox(height: 12),
            TextField(
              controller: pin,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'App PIN'),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: FinzeeColors.expense),
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Wipe everything'),
        ),
      ],
    ),
  );
  if (second != true) return null;
  return WipeDraft(phrase: phrase.text, pin: pinRequired ? pin.text : null);
}

class AddCta extends StatelessWidget {
  const AddCta({super.key, required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add),
        label: Text(label),
      ),
    );
  }
}

List<Widget> addAppBarAction(VoidCallback onAdd, String tooltip) {
  return [
    IconButton(
      tooltip: tooltip,
      onPressed: onAdd,
      icon: const Icon(Icons.add_circle),
    ),
  ];
}
