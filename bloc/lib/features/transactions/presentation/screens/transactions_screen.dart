import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plaid/features/transactions/domain/cubits/transactions_cubit.dart';
import '/shared/strings.dart';
import '/shared/constants.dart';
import '../../../../shared/domain/models/transaction/transaction.dart';
import '../../../../shared/widgets/list_item.dart';

// Transactions Screen
class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {

  // Lifecycle methods
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<TransactionsCubit>();
      cubit.fetchTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.transactionsTitle),
        centerTitle: true,
      ),
      body: BlocBuilder<TransactionsCubit, TransactionsState>(
        builder: (context, state) {
          // Evaluating cubit states
          if (state is InitTransactionsState || state is LoadingTransactionsState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ResponseTransactionsState) {
            final transactions = state.transactions;
            return _buildTransactionList(transactions);
          } else {
            return const Center(child: Text('Error getting transactions'));
          }
        },
      ),
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