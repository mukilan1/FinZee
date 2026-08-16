# FinZee architecture

Layering:

```
Presentation (Flutter widgets)
    → FinanceController / FinanceApp
        → MonthlyPlanningService / FinancialCalculationService / BackupService
            → FinanceRepository
                → Drift / SQLite
```

## One source of truth

Completing an allocation creates **one** `FinanceTransaction`. That event updates account balances, savings goal amounts, investment records, dashboard totals, reports, and the audit log. Reports never store a second copy of money.

## Feature toggles

`OFF` hides UI and skips planning automation. Rows stay in SQLite. Re-enabling restores the module.

## Money

Amounts are integer minor units (paise). Never `double` for stored values.

## Offline

No HTTP client is used for product features. Backup is a versioned local JSON file (`schemaVersion: 1`).
