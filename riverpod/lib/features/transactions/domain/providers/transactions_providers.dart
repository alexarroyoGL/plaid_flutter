import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/transactions_datasource.dart';
import '../../data/repositories/transactions_repository_impl.dart';
import '../repositories/transactions_repository.dart';

// Transactions data source provider
final transactionsDataSourceProvider = Provider<TransactionsDataSource>((ref) => TransactionsDataSourceImpl());

// Transactions repository provider
final transactionsRepositoryProvider = Provider<TransactionsRepository>((ref) {
  final TransactionsDataSource dataSource = ref.watch(transactionsDataSourceProvider);
  return TransactionsRepositoryImpl(dataSource);
});