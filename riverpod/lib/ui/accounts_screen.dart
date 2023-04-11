import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/utils/strings.dart';
import '../app.dart';
import '../data/account.dart';

// Accounts future provider
final accountsFutureProvider = FutureProvider.autoDispose<List<Account>>((ref) {
  // Get repository from the provider above
  final plaidRepository = ref.watch(plaidRepositoryProvider);
  // Call method that returns a List<Account>
  return plaidRepository.fetchAccounts();
});

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  // Lifecycle methods
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Getting accounts from provider
    final accountsAsync = ref.watch(accountsFutureProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.accountsTitle),
        ),
        body: accountsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (transactions) => _buildTransactionList(transactions),
        )
    );
  }

  // Private methods
  Widget _buildTransactionList(List<Account> accounts) {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: accounts.length,
        itemBuilder: (BuildContext context, int position) {
          return _buildRow(accounts[position]);
        }
    );
  }

  Widget _buildRow(Account account) {
    return Card(
      child: ListTile(
          title: Text('Name: ${account.name}\nType: ${account.type}', style: const TextStyle(fontSize: 18.0)),
          subtitle: Text('Available: ${account.available ?? '0'} - Current: ${account.current ?? '0'}')
      ),
    );
  }

}


