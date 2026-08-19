import 'package:flutter/material.dart';

import '../../app/theme.dart';
import 'feedback.dart';
import 'finzee_ui.dart';

class FilterGroup {
  const FilterGroup({
    required this.id,
    required this.label,
    required this.options,
  });

  final String id;
  final String label;
  /// Map of value → label. Use `null` key for "All".
  final List<(String?, String)> options;
}

class ListControls extends StatefulWidget {
  const ListControls({
    super.key,
    required this.query,
    required this.onQuery,
    this.hint = 'Search',
    this.filterGroups = const [],
    this.activeFilters = const {},
    this.onFiltersChanged,
    this.sorts = const [],
    this.sortId,
    this.onSort,
    // Legacy single-filter API (mapped to one group internally when used alone)
    this.filters = const [],
    this.selectedFilter,
    this.onFilter,
  });

  final String query;
  final ValueChanged<String> onQuery;
  final String hint;
  final List<FilterGroup> filterGroups;
  final Map<String, String?> activeFilters;
  final ValueChanged<Map<String, String?>>? onFiltersChanged;
  final List<(String id, String label)> sorts;
  final String? sortId;
  final ValueChanged<String>? onSort;
  final List<String> filters;
  final String? selectedFilter;
  final ValueChanged<String?>? onFilter;

  @override
  State<ListControls> createState() => _ListControlsState();
}

class _ListControlsState extends State<ListControls> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.query);
  }

  @override
  void didUpdateWidget(ListControls oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.query != oldWidget.query && widget.query != _searchController.text) {
      _searchController.text = widget.query;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<FilterGroup> get _groups {
    if (widget.filterGroups.isNotEmpty) return widget.filterGroups;
    if (widget.filters.isEmpty) return const [];
    return [
      FilterGroup(
        id: 'filter',
        label: 'Filter',
        options: [(null, 'All'), ...widget.filters.map((f) => (f, f))],
      ),
    ];
  }

  Map<String, String?> get _active {
    if (widget.filterGroups.isNotEmpty) {
      return {
        for (final g in widget.filterGroups) g.id: widget.activeFilters[g.id],
      };
    }
    if (widget.filters.isEmpty) return const {};
    return {'filter': widget.selectedFilter};
  }

  int get _activeCount {
    var count = 0;
    for (final g in _groups) {
      final v = _active[g.id];
      if (v != null) count++;
    }
    if (widget.sorts.isNotEmpty &&
        widget.sortId != null &&
        widget.sortId != widget.sorts.first.$1) {
      count++;
    }
    return count;
  }

  Map<String, String?> _seedDraft() {
    final draft = <String, String?>{};
    for (final g in _groups) {
      draft[g.id] = _active[g.id];
    }
    return draft;
  }

  Future<void> _openFilters(BuildContext context) async {
    var draft = _seedDraft();
    var draftSort = widget.sortId ?? (widget.sorts.isEmpty ? null : widget.sorts.first.$1);
    final result = await showFinzeeBottomSheet<(Map<String, String?>, String?)>(
      context,
      child: StatefulBuilder(
        builder: (ctx, setSt) {
          final maxHeight = MediaQuery.of(ctx).size.height * 0.6;
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const FinzeeSheetHeader(title: 'Filters & sort'),
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: maxHeight),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final group in _groups) ...[
                          FinzeeSectionLabel(group.label),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: group.options.map((opt) {
                              final selected = draft[group.id] == opt.$1;
                              return ChoiceChip(
                                label: Text(opt.$2),
                                selected: selected,
                                onSelected: (_) => setSt(() {
                                  draft[group.id] = opt.$1;
                                }),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: FinzeeSpacing.lg),
                        ],
                        if (widget.sorts.isNotEmpty) ...[
                          const FinzeeSectionLabel('Sort by'),
                          ...widget.sorts.map(
                            (s) => RadioListTile<String>(
                              title: Text(s.$2),
                              value: s.$1,
                              groupValue: draftSort,
                              contentPadding: EdgeInsets.zero,
                              onChanged: (v) => setSt(() => draftSort = v),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: FinzeeSpacing.md),
                Row(
                  children: [
                    TextButton(
                      onPressed: () => setSt(() {
                        draft = {
                          for (final g in _groups) g.id: null,
                        };
                        draftSort = widget.sorts.isEmpty ? null : widget.sorts.first.$1;
                      }),
                      child: const Text('Reset'),
                    ),
                    const Spacer(),
                    FilledButton(
                      onPressed: () => Navigator.pop(ctx, (draft, draftSort)),
                      child: const Text('Apply'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
    if (result == null) return;

    final appliedFilters = _seedDraft();
    appliedFilters.addAll(result.$1);

    if (widget.onFiltersChanged != null) {
      widget.onFiltersChanged!(appliedFilters);
    } else if (widget.onFilter != null) {
      widget.onFilter!(appliedFilters['filter']);
    }

    final newSort = result.$2;
    if (newSort != null && widget.onSort != null) {
      widget.onSort!(newSort);
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = context.finzee;
    final hasFilters = _groups.isNotEmpty || widget.sorts.isNotEmpty;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: widget.hint,
              isDense: true,
            ),
            onChanged: widget.onQuery,
          ),
        ),
        if (hasFilters) ...[
          const SizedBox(width: FinzeeSpacing.sm),
          IconButton(
            tooltip: 'Filters',
            onPressed: () => _openFilters(context),
            icon: Badge(
              isLabelVisible: _activeCount > 0,
              label: Text('$_activeCount'),
              child: const Icon(Icons.tune),
            ),
            style: IconButton.styleFrom(
              foregroundColor: palette.primaryDark,
              backgroundColor: palette.primarySoft,
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
    final palette = context.finzee;
    return Material(
      color: palette.background,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onPick,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: TextStyle(color: palette.textSecondary, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(
                      '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}',
                      style: TextStyle(
                        color: palette.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.calendar_today_outlined, color: palette.primaryDark, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

Future<bool> confirmDelete(
  BuildContext context, {
  required String title,
  String body = 'This cannot be undone. The record is removed from this device only.',
  String confirmLabel = 'Delete',
}) async {
  final palette = context.finzee;
  final ok = await showFinzeeDialog<bool>(
    context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: palette.expense),
          onPressed: () => Navigator.pop(dialogContext, true),
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
  final palette = context.finzee;
  await showFinzeeDialog<void>(
    context,
    builder: (dialogContext) => AlertDialog(
      title: Row(
        children: [
          Icon(
            success ? Icons.check_circle_outline : Icons.error_outline,
            color: success ? palette.income : palette.expense,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(title)),
        ],
      ),
      content: Text(body),
      actions: [
        FilledButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('OK'),
        ),
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
  if (success) {
    showFinzeeSnackBar(context, doneBody);
  } else {
    showFinzeeSnackBar(
      context,
      failBody?.call() ?? 'Nothing was erased.',
      error: true,
    );
  }
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
  if (success) {
    showFinzeeSnackBar(pageContext, doneBody);
  } else {
    showFinzeeSnackBar(
      pageContext,
      failBody?.call() ?? 'Nothing was erased.',
      error: true,
    );
  }
}

class WipeDraft {
  const WipeDraft({required this.phrase});
  final String phrase;
}

Future<WipeDraft?> collectWipeDraft(
  BuildContext context, {
  required bool authRequired,
  required Future<bool> Function(String reason) authenticate,
}) async {
  final palette = context.finzee;
  final first = await showFinzeeDialog<bool>(
    context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Delete all FinZee data?'),
      content: const Text(
        'This permanently wipes accounts, transactions, plans, goals, and settings on this device.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: palette.expense),
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Continue'),
        ),
      ],
    ),
  );
  if (first != true || !context.mounted) return null;

  final phrase = TextEditingController();
  final second = await showFinzeeDialog<bool>(
    context,
    builder: (dialogContext) => AlertDialog(
      title: const Text('Type DELETE to confirm'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Second warning: type DELETE in capital letters.'),
          const SizedBox(height: FinzeeSpacing.md),
          TextField(
            controller: phrase,
            decoration: const InputDecoration(labelText: 'Type DELETE'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: palette.expense),
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Wipe everything'),
        ),
      ],
    ),
  );
  if (second != true) return null;
  if (authRequired) {
    final authed = await authenticate('Confirm deleting all FinZee data');
    if (!authed) return null;
  }
  return WipeDraft(phrase: phrase.text);
}
