import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/utils/strings.dart';
import '../app.dart';
import '../data/transaction.dart';

// Transactions future provider
final transactionsFutureProvider = FutureProvider.autoDispose<List<Transaction>>((ref) {
  // Get repository from the provider above
  final plaidRepository = ref.watch(plaidRepositoryProvider);
  // Call method that returns a Future<List<Transaction>>
  return plaidRepository.fetchTransactions();
});

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  // Lifecycle methods
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Getting transactions from provider
    final transactionsAsync = ref.watch(transactionsFutureProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.transactionsTitle),
      ),
      body: transactionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (transactions) => _buildTransactionList(transactions),
      )
    );
  }

  // Private methods
  Widget _buildTransactionList(List<Transaction> transactions) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: transactions.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildRow(transactions[position]);
        }
    );
  }

  Widget _buildRow(Transaction transaction) {
    return Card(
      child: ListTile(
          title: Text('Merchant: ${transaction.merchantName}\nAmount: ${transaction.amount.toString()}', style: const TextStyle(fontSize: 18.0)),
          subtitle: Text('Date: ${transaction.date} - Currency: ${transaction.currencyCode}')
      ),
    );
  }

}