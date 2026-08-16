import 'dart:convert';

import '../core/errors.dart';
import '../core/features.dart';
import '../core/ids.dart';
import '../core/money.dart';
import '../database/finance_repository.dart';
import '../domain/entities.dart';

const backupSchemaVersion = 1;

class BackupSummary {
  const BackupSummary({
    required this.schemaVersion,
    required this.exportedAt,
    required this.accountCount,
    required this.transactionCount,
    required this.planCount,
  });

  final int schemaVersion;
  final DateTime exportedAt;
  final int accountCount;
  final int transactionCount;
  final int planCount;
}

class BackupService {
  BackupService(this.repo);
  final FinanceRepository repo;

  Future<String> exportJson() async {
    final accounts = await repo.accounts(includeArchived: true);
    final categories = await repo.categories();
    final txs = await repo.transactions();
    final features = await repo.loadFeatures();
    final salary = await repo.activeSalary();
    final history = await repo.salaryHistory();
    final templates = await repo.templates();
    final now = DateTime.now();
    final plan = await repo.planFor(now.year, now.month);
    final allocations =
        plan == null ? <AllocationItem>[] : await repo.allocationsFor(plan.id);
    final goals = await repo.savingsGoals();
    final investments = await repo.investments();
    final bills = await repo.bills();
    final loans = await repo.loans();
    final notes = await repo.notes();
    final audits = await repo.auditLog();
    final finGoals = await repo.financialGoals();

    final payload = {
      'schemaVersion': backupSchemaVersion,
      'exportedAt': now.toIso8601String(),
      'features': {
        for (final e in features.entries) e.key.key: e.value,
      },
      'accounts': accounts
          .map((a) => {
                'id': a.id,
                'name': a.name,
                'type': a.type.name,
                'openingBalanceMinor': a.openingBalance.minor,
                'currency': a.currency,
                'notes': a.notes,
                'archived': a.archived,
                'createdAt': a.createdAt.toIso8601String(),
              })
          .toList(),
      'categories': categories
          .map((c) => {
                'id': c.id,
                'name': c.name,
                'kind': c.kind.name,
                'parentId': c.parentId,
                'icon': c.icon,
                'sortOrder': c.sortOrder,
                'archived': c.archived,
              })
          .toList(),
      'transactions': txs
          .map((t) => {
                'id': t.id,
                'type': t.type.name,
                'amountMinor': t.amount.minor,
                'date': t.date.toIso8601String(),
                'accountId': t.accountId,
                'toAccountId': t.toAccountId,
                'categoryId': t.categoryId,
                'note': t.note,
                'allocationItemId': t.allocationItemId,
                'goalId': t.goalId,
                'investmentId': t.investmentId,
                'createdAt': t.createdAt.toIso8601String(),
              })
          .toList(),
      'salary': salary == null
          ? null
          : {
              'id': salary.id,
              'baseAmountMinor': salary.baseAmount.minor,
              'payDay': salary.payDay,
              'frequency': salary.frequency,
              'currency': salary.currency,
              'source': salary.source,
              'effectiveFrom': salary.effectiveFrom.toIso8601String(),
            },
      'salaryHistory': history
          .map((h) => {
                'id': h.id,
                'previousAmountMinor': h.previousAmount.minor,
                'newAmountMinor': h.newAmount.minor,
                'effectiveDate': h.effectiveDate.toIso8601String(),
                'reason': h.reason,
                'notes': h.notes,
              })
          .toList(),
      'templates': templates
          .map((t) => {
                'id': t.id,
                'name': t.name,
                'kind': t.kind.name,
                'plannedAmountMinor': t.plannedAmount.minor,
                'categoryId': t.categoryId,
                'goalId': t.goalId,
                'sortOrder': t.sortOrder,
              })
          .toList(),
      'plan': plan == null
          ? null
          : {
              'id': plan.id,
              'year': plan.year,
              'month': plan.month,
              'expectedIncomeMinor': plan.expectedIncome.minor,
              'confirmed': plan.confirmed,
              'createdAt': plan.createdAt.toIso8601String(),
            },
      'allocations': allocations
          .map((a) => {
                'id': a.id,
                'planId': a.planId,
                'name': a.name,
                'kind': a.kind.name,
                'plannedAmountMinor': a.plannedAmount.minor,
                'actualAmountMinor': a.actualAmount?.minor,
                'status': a.status.name,
                'goalId': a.goalId,
                'skipReason': a.skipReason?.name,
                'skipNote': a.skipNote,
                'sortOrder': a.sortOrder,
                'accountId': a.accountId,
                'categoryId': a.categoryId,
              })
          .toList(),
      'savingsGoals': goals
          .map((g) => {
                'id': g.id,
                'name': g.name,
                'targetAmountMinor': g.targetAmount.minor,
                'currentAmountMinor': g.currentAmount.minor,
                'monthlyContributionMinor': g.monthlyContribution?.minor,
                'priority': g.priority,
              })
          .toList(),
      'investments': investments
          .map((i) => {
                'id': i.id,
                'name': i.name,
                'type': i.type,
                'amountMinor': i.amount.minor,
                'date': i.date.toIso8601String(),
                'currentValueMinor': i.currentValue?.minor,
              })
          .toList(),
      'bills': bills
          .map((b) => {
                'id': b.id,
                'name': b.name,
                'amountMinor': b.amount.minor,
                'dueDay': b.dueDay,
                'categoryId': b.categoryId,
              })
          .toList(),
      'loans': loans
          .map((l) => {
                'id': l.id,
                'name': l.name,
                'principalMinor': l.principal.minor,
                'interestRate': l.interestRate,
                'emiMinor': l.emi.minor,
                'startDate': l.startDate.toIso8601String(),
                'endDate': l.endDate.toIso8601String(),
                'remainingMinor': l.remaining.minor,
              })
          .toList(),
      'financialGoals': finGoals
          .map((g) => {
                'id': g.id,
                'name': g.name,
                'targetAmountMinor': g.targetAmount.minor,
                'currentAmountMinor': g.currentAmount.minor,
                'kind': g.kind,
              })
          .toList(),
      'notes': notes
          .map((n) => {
                'id': n.id,
                'body': n.body,
                'createdAt': n.createdAt.toIso8601String(),
                'allocationId': n.allocationId,
              })
          .toList(),
      'auditLogs': audits
          .map((a) => {
                'id': a.id,
                'action': a.action,
                'at': a.at.toIso8601String(),
                'payload': a.payload,
              })
          .toList(),
    };
    await repo.audit('BACKUP_CREATED');
    return const JsonEncoder.withIndent('  ').convert(payload);
  }

  BackupSummary summarize(String json) {
    final map = _parse(json);
    return BackupSummary(
      schemaVersion: map['schemaVersion'] as int,
      exportedAt: DateTime.parse(map['exportedAt'] as String),
      accountCount: (map['accounts'] as List).length,
      transactionCount: (map['transactions'] as List).length,
      planCount: map['plan'] == null ? 0 : 1,
    );
  }

  Future<BackupSummary> restore(String json, {required String safetyBackup}) async {
    final map = _parse(json);
    if ((map['schemaVersion'] as int) != backupSchemaVersion) {
      throw const MigrationError('Unsupported backup schema version.');
    }
    summarize(safetyBackup);
    await repo.clearAll();
    await _restoreFrom(map);
    await repo.audit('BACKUP_RESTORED');
    return summarize(json);
  }

  Map<String, dynamic> _parse(String json) {
    try {
      final decoded = jsonDecode(json);
      if (decoded is! Map<String, dynamic>) {
        throw const ImportError('Invalid backup.');
      }
      if (decoded['schemaVersion'] is! int) {
        throw const ImportError('Backup schema version missing.');
      }
      return decoded;
    } on ImportError {
      rethrow;
    } catch (_) {
      throw const ImportError('Invalid backup file.');
    }
  }

  Future<void> _restoreFrom(Map<String, dynamic> map) async {
    final features = map['features'] as Map<String, dynamic>? ?? {};
    for (final feature in AppFeature.values) {
      await repo.setFeature(feature, features[feature.key] == true);
    }
    for (final raw in map['accounts'] as List) {
      final a = raw as Map<String, dynamic>;
      await repo.upsertAccount(
        Account(
          id: a['id'] as String,
          name: a['name'] as String,
          type: AccountType.values.byName(a['type'] as String),
          openingBalance: Money(a['openingBalanceMinor'] as int),
          currency: a['currency'] as String? ?? 'INR',
          notes: a['notes'] as String?,
          archived: a['archived'] as bool? ?? false,
          createdAt: DateTime.parse(a['createdAt'] as String),
        ),
      );
    }
    for (final raw in map['categories'] as List) {
      final c = raw as Map<String, dynamic>;
      await repo.upsertCategory(
        Category(
          id: c['id'] as String,
          name: c['name'] as String,
          kind: CategoryKind.values.byName(c['kind'] as String),
          parentId: c['parentId'] as String?,
          icon: c['icon'] as String? ?? 'category',
          sortOrder: c['sortOrder'] as int? ?? 0,
          archived: c['archived'] as bool? ?? false,
        ),
      );
    }
    if (map['salary'] is Map<String, dynamic>) {
      final s = map['salary'] as Map<String, dynamic>;
      await repo.insertSalaryProfile(
        SalaryProfile(
          id: s['id'] as String,
          baseAmount: Money(s['baseAmountMinor'] as int),
          payDay: s['payDay'] as int,
          frequency: s['frequency'] as String? ?? 'monthly',
          currency: s['currency'] as String? ?? 'INR',
          source: s['source'] as String? ?? 'Employer',
          effectiveFrom: DateTime.parse(s['effectiveFrom'] as String),
        ),
      );
    }
    for (final raw in map['salaryHistory'] as List? ?? []) {
      final h = raw as Map<String, dynamic>;
      await repo.insertSalaryHistory(
        SalaryHistoryEntry(
          id: h['id'] as String,
          previousAmount: Money(h['previousAmountMinor'] as int),
          newAmount: Money(h['newAmountMinor'] as int),
          effectiveDate: DateTime.parse(h['effectiveDate'] as String),
          reason: h['reason'] as String?,
          notes: h['notes'] as String?,
        ),
      );
    }
    final templates = <AllocationTemplateItem>[];
    for (final raw in map['templates'] as List? ?? []) {
      final t = raw as Map<String, dynamic>;
      templates.add(
        AllocationTemplateItem(
          id: t['id'] as String,
          name: t['name'] as String,
          kind: AllocationKind.values.byName(t['kind'] as String),
          plannedAmount: Money(t['plannedAmountMinor'] as int),
          categoryId: t['categoryId'] as String?,
          goalId: t['goalId'] as String?,
          sortOrder: t['sortOrder'] as int? ?? 0,
        ),
      );
    }
    await repo.replaceTemplates(templates);
    if (map['plan'] is Map<String, dynamic>) {
      final p = map['plan'] as Map<String, dynamic>;
      await repo.upsertPlan(
        MonthlyPlan(
          id: p['id'] as String,
          year: p['year'] as int,
          month: p['month'] as int,
          expectedIncome: Money(p['expectedIncomeMinor'] as int),
          confirmed: p['confirmed'] as bool? ?? false,
          createdAt: DateTime.parse(p['createdAt'] as String),
        ),
      );
    }
    for (final raw in map['allocations'] as List? ?? []) {
      final a = raw as Map<String, dynamic>;
      await repo.upsertAllocation(
        AllocationItem(
          id: a['id'] as String,
          planId: a['planId'] as String,
          name: a['name'] as String,
          kind: AllocationKind.values.byName(a['kind'] as String),
          plannedAmount: Money(a['plannedAmountMinor'] as int),
          actualAmount: a['actualAmountMinor'] == null
              ? null
              : Money(a['actualAmountMinor'] as int),
          status: AllocationStatus.values.byName(a['status'] as String),
          goalId: a['goalId'] as String?,
          skipReason: a['skipReason'] == null
              ? null
              : SkipReason.values.byName(a['skipReason'] as String),
          skipNote: a['skipNote'] as String?,
          sortOrder: a['sortOrder'] as int? ?? 0,
          accountId: a['accountId'] as String?,
          categoryId: a['categoryId'] as String?,
        ),
      );
    }
    for (final raw in map['savingsGoals'] as List? ?? []) {
      final g = raw as Map<String, dynamic>;
      await repo.upsertSavingsGoal(
        SavingsGoal(
          id: g['id'] as String,
          name: g['name'] as String,
          targetAmount: Money(g['targetAmountMinor'] as int),
          currentAmount: Money(g['currentAmountMinor'] as int),
          monthlyContribution: g['monthlyContributionMinor'] == null
              ? null
              : Money(g['monthlyContributionMinor'] as int),
          priority: g['priority'] as int? ?? 1,
        ),
      );
    }
    for (final raw in map['investments'] as List? ?? []) {
      final i = raw as Map<String, dynamic>;
      await repo.upsertInvestment(
        Investment(
          id: i['id'] as String,
          name: i['name'] as String,
          type: i['type'] as String,
          amount: Money(i['amountMinor'] as int),
          date: DateTime.parse(i['date'] as String),
          currentValue: i['currentValueMinor'] == null
              ? null
              : Money(i['currentValueMinor'] as int),
        ),
      );
    }
    for (final raw in map['bills'] as List? ?? []) {
      final b = raw as Map<String, dynamic>;
      await repo.upsertBill(
        RecurringBill(
          id: b['id'] as String,
          name: b['name'] as String,
          amount: Money(b['amountMinor'] as int),
          dueDay: b['dueDay'] as int,
          categoryId: b['categoryId'] as String?,
        ),
      );
    }
    for (final raw in map['loans'] as List? ?? []) {
      final l = raw as Map<String, dynamic>;
      await repo.upsertLoan(
        Loan(
          id: l['id'] as String,
          name: l['name'] as String,
          principal: Money(l['principalMinor'] as int),
          interestRate: (l['interestRate'] as num).toDouble(),
          emi: Money(l['emiMinor'] as int),
          startDate: DateTime.parse(l['startDate'] as String),
          endDate: DateTime.parse(l['endDate'] as String),
          remaining: Money(l['remainingMinor'] as int),
        ),
      );
    }
    for (final raw in map['financialGoals'] as List? ?? []) {
      final g = raw as Map<String, dynamic>;
      await repo.upsertFinancialGoal(
        FinancialGoal(
          id: g['id'] as String,
          name: g['name'] as String,
          targetAmount: Money(g['targetAmountMinor'] as int),
          currentAmount: Money(g['currentAmountMinor'] as int? ?? 0),
          kind: g['kind'] as String? ?? 'general',
        ),
      );
    }
    for (final raw in map['notes'] as List? ?? []) {
      final n = raw as Map<String, dynamic>;
      await repo.insertNote(
        FinanceNote(
          id: n['id'] as String? ?? newId(),
          body: n['body'] as String,
          createdAt: DateTime.parse(n['createdAt'] as String),
          allocationId: n['allocationId'] as String?,
        ),
      );
    }
    for (final raw in map['transactions'] as List) {
      final t = raw as Map<String, dynamic>;
      await repo.insertTransaction(
        FinanceTransaction(
          id: t['id'] as String,
          type: TransactionType.values.byName(t['type'] as String),
          amount: Money(t['amountMinor'] as int),
          date: DateTime.parse(t['date'] as String),
          accountId: t['accountId'] as String,
          toAccountId: t['toAccountId'] as String?,
          categoryId: t['categoryId'] as String?,
          note: t['note'] as String?,
          allocationItemId: t['allocationItemId'] as String?,
          goalId: t['goalId'] as String?,
          investmentId: t['investmentId'] as String?,
          createdAt: DateTime.parse(t['createdAt'] as String),
        ),
      );
    }
  }
}
