import 'transaction.dart';
import 'account.dart';

abstract class Repository {
  Future<String> getLinkToken();
  Future<void> getAccessToken(String publicToken);
  Future<List<Transaction>> fetchTransactions();
  Future<List<Account>> fetchAccounts();
}