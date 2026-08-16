import '../core/errors.dart';
import '../core/money.dart';
import '../domain/entities.dart';

void requirePositiveAmount(Money amount) {
  if (amount.minor <= 0) {
    throw const ValidationError('Amount must be greater than zero.');
  }
}

void requireAccount(Account? account) {
  if (account == null || account.archived) {
    throw const ValidationError('Account must exist before creating a transaction.');
  }
}

void requireCategory(Category? category) {
  if (category == null || category.archived) {
    throw const ValidationError('Category must exist.');
  }
}

void requireDifferentAccounts(String fromId, String toId) {
  if (fromId == toId) {
    throw const ValidationError('Transfer source and destination cannot be identical.');
  }
}

void requireValidCurrency(String currency) {
  if (currency.length != 3) {
    throw const ValidationError('Currency must be a 3-letter code.');
  }
}

void requireValidDate(DateTime date) {
  if (date.year < 1970 || date.year > 2200) {
    throw const ValidationError('Date is not valid.');
  }
}

void requirePayDay(int day) {
  if (day < 1 || day > 31) {
    throw const ValidationError('Salary date must be between 1 and 31.');
  }
}
