enum AuditAction {
  salaryCreated,
  salaryUpdated,
  allocationCreated,
  allocationCompleted,
  allocationSkipped,
  allocationPartial,
  transactionCreated,
  transactionUpdated,
  transactionDeleted,
  goalUpdated,
  backupCreated,
  backupRestored,
  featureEnabled,
  featureDisabled,
  planGenerated,
  planConfirmed,
  accountCreated,
}

extension AuditActionX on AuditAction {
  String get key => name.toUpperCase().replaceAllMapped(
        RegExp(r'[A-Z]'),
        (m) => '_${m.group(0)}',
      ).replaceFirst('_', '').toUpperCase();
}
