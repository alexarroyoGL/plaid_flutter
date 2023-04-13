import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/transactions_datasource.dart';
import '../../data/repositories/transactions_repository_impl.dart';

// Transactions data source provider
final transactionsDataSourceProvider = Provider<TransactionsDataSourceImpl>((ref) => TransactionsDataSourceImpl());

// Transactions repository provider
final transactionsRepositoryProvider = Provider<TransactionsRepositoryImpl>((ref) {
  final TransactionsDataSourceImpl dataSource = ref.watch(transactionsDataSourceProvider);
  return TransactionsRepositoryImpl(dataSource);
});