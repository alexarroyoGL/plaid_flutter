import '../../../../shared/domain/models/transaction/transaction.dart';

abstract class TransactionsRepository {
  Future<List<Transaction>> fetchTransactions();
}