import 'dart:convert';

/// Saved search + filter + sort state for a list screen.
class ListQueryState {
  const ListQueryState({
    this.query = '',
    this.filters = const {},
    this.sortId,
  });

  final String query;
  final Map<String, String?> filters;
  final String? sortId;

  static const settingsPrefix = 'list_query_';

  ListQueryState copyWith({
    String? query,
    Map<String, String?>? filters,
    String? sortId,
    bool clearSort = false,
  }) {
    return ListQueryState(
      query: query ?? this.query,
      filters: filters ?? this.filters,
      sortId: clearSort ? null : (sortId ?? this.sortId),
    );
  }

  Map<String, dynamic> toJson() => {
        'query': query,
        'filters': {
          for (final e in filters.entries) e.key: e.value,
        },
        'sortId': sortId,
      };

  factory ListQueryState.fromJson(Map<String, dynamic> json) {
    final rawFilters = json['filters'];
    final parsedFilters = <String, String?>{};
    if (rawFilters is Map) {
      for (final entry in rawFilters.entries) {
        final value = entry.value;
        parsedFilters['${entry.key}'] = value == null ? null : '$value';
      }
    }
    return ListQueryState(
      query: json['query'] as String? ?? '',
      filters: parsedFilters,
      sortId: json['sortId'] as String?,
    );
  }

  static ListQueryState decode(String? raw, {required String defaultSort}) {
    if (raw == null || raw.isEmpty) return ListQueryState(sortId: defaultSort);
    try {
      final json = jsonDecode(raw);
      if (json is! Map<String, dynamic>) return ListQueryState(sortId: defaultSort);
      final state = ListQueryState.fromJson(json);
      return ListQueryState(
        query: state.query,
        filters: state.filters,
        sortId: state.sortId ?? defaultSort,
      );
    } catch (_) {
      return ListQueryState(sortId: defaultSort);
    }
  }

  String encode() => jsonEncode(toJson());
}

/// Stable keys for persisted list filters (stored in app_settings / backup).
abstract final class ListQueryKeys {
  static const transactions = 'transactions';
  static const goals = 'goals';
  static const plan = 'plan';
  static const notifications = 'notifications';
  static const accounts = 'accounts';
  static const categories = 'categories';
  static const investments = 'investments';
  static const bills = 'bills';
  static const loans = 'loans';
  static const budgets = 'budgets';
  static const notes = 'notes';
  static const reports = 'reports';

  static String reportMonth(int year, int month) => 'report_${year}_${month.toString().padLeft(2, '0')}';
}
