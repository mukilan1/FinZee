enum AppFeature {
  salaryPlanning,
  savingsGoals,
  investments,
  budgets,
  bills,
  loans,
  financialGoals,
  netWorth,
}

extension AppFeatureX on AppFeature {
  String get key => name;

  String get label => switch (this) {
        AppFeature.salaryPlanning => 'Salary Planning',
        AppFeature.savingsGoals => 'Savings Goals',
        AppFeature.investments => 'Investments',
        AppFeature.budgets => 'Budgets',
        AppFeature.bills => 'Bills',
        AppFeature.loans => 'Loans',
        AppFeature.financialGoals => 'Financial Goals',
        AppFeature.netWorth => 'Net Worth',
      };
}

const defaultFeatureStates = <AppFeature, bool>{
  AppFeature.salaryPlanning: false,
  AppFeature.savingsGoals: true,
  AppFeature.investments: false,
  AppFeature.budgets: true,
  AppFeature.bills: false,
  AppFeature.loans: false,
  AppFeature.financialGoals: true,
  AppFeature.netWorth: true,
};
