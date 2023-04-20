import 'package:plaid/shared/domain/models/transaction/transaction.dart';
import '../../domain/repositories/transactions_repository.dart';
import '../datasource/transactions_datasource.dart';

class TransactionsRepositoryImpl extends TransactionsRepository {
  // Properties
  final TransactionsDataSource dataSource;

  // Constructor
  TransactionsRepositoryImpl(this.dataSource);

  // Overriding methods
  @override
  Future<List<Transaction>> fetchTransactions() {
    return dataSource.fetchTransactions();
  }

}