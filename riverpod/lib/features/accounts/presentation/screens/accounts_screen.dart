import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plaid/shared/constants.dart';
import '../providers/accounts_providers.dart';
import '/shared/strings.dart';
import '../../../../shared/domain/models/account/account.dart';
import '../../../../shared/widgets/list_item.dart';

// Accounts screen
class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  // Lifecycle methods
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Getting accounts from provider
    final accountsAsync = ref.watch(accountsProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.accountsTitle),
          centerTitle: true,
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
    return ListItem(
        title: 'Name: ${account.name}\nType: ${account.type}',
        subtitle: 'Available: ${account.available ?? '0'} - Current: ${account.current ?? '0'}',
        iconUrl: Constants.kAuthIcon
    );
  }

}


