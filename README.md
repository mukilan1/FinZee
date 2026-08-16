# FinZee

100% offline, privacy-first personal finance manager for Flutter.

There is **no** registration, login, cloud, backend, analytics, ads, or bank API. All data lives in local SQLite (Drift).

## Modes

- **Mode A** — track income, expenses, transfers, accounts, and reports (salary planning off).
- **Mode B** — enable Salary Planning for monthly allocation, checklist, planned vs actual, skip reasons, and savings/investment integration.

One financial event is the source of truth: allocation → transaction → goal/account → dashboard → reports → audit.

## Run

Flutter SDK is not required to be globally installed if you already have it. From this folder:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter test
flutter run
```

## Architecture

`UI → FinanceApp (application) → domain services → FinanceRepository → Drift/SQLite`

See `.cursor/rules/finzee-architecture.mdc` for the ten production rules.

## Tests

`flutter test` covers money math, transfer/savings invariants, the salary→plan→goal journey, feature-toggle persistence, backup/restore, and a dashboard widget smoke test.
