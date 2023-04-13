import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/domain/models/transaction/transaction.dart';
import '../../domain/providers/transactions_providers.dart';

// Transactions provider
final transactionsProvider = FutureProvider.autoDispose<List<Transaction>>((ref) {
  final transactionsRepository = ref.watch(transactionsRepositoryProvider);
  return transactionsRepository.fetchTransactions();
});