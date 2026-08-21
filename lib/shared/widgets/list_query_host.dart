import 'package:flutter/material.dart';

import '../../app/finance_scope.dart';
import '../list_query.dart';

/// Loads and applies persisted list filters for a screen.
mixin PersistentListQuery<T extends StatefulWidget> on State<T> {
  ListQueryState listQuery = const ListQueryState();
  bool listQueryReady = false;

  String get listQueryKey;
  String get listQueryDefaultSort;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => restoreListQuery());
  }

  Future<void> restoreListQuery() async {
    final app = FinanceScope.of(context).app;
    final saved = await app.loadListQuery(listQueryKey, defaultSort: listQueryDefaultSort);
    if (!mounted) return;
    setState(() {
      listQuery = saved;
      listQueryReady = true;
    });
  }

  void applyListQuery(ListQueryState next) {
    setState(() => listQuery = next);
  }

  String? listFilter(String id) => listQuery.filters[id];

  String get listSortId => listQuery.sortId ?? listQueryDefaultSort;
}
