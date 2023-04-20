import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/shared/strings.dart';
import '/shared/constants.dart';
import '../providers/transactions_providers.dart';
import '../../../../shared/domain/models/transaction/transaction.dart';
import '../../../../shared/widgets/list_item.dart';

// Transactions Screen
class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  // Lifecycle methods
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.transactionsTitle),
        centerTitle: true,
      ),
      body: ref.watch(transactionsProvider).when(
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
    return ListItem(
        title: 'Merchant: ${transaction.merchantName}\nAmount: ${transaction.amount.toString()}',
        subtitle: 'Date: ${transaction.date} - Currency: ${transaction.currencyCode}',
        iconUrl: Constants.kTransactionIcon
    );
  }

}