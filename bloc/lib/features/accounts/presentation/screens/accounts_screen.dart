import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plaid/features/accounts/domain/cubits/accounts_cubit.dart';
import 'package:plaid/shared/constants.dart';
import '/shared/strings.dart';
import '../../../../shared/domain/models/account/account.dart';
import '../../../../shared/widgets/list_item.dart';

// Accounts screen
class AccountsScreen extends StatefulWidget {
  const AccountsScreen({Key? key}) : super(key: key);

  @override
  State<AccountsScreen> createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> {

  // Lifecycle methods
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<AccountsCubit>();
      cubit.fetchAccounts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Strings.accountsTitle),
          centerTitle: true,
        ),
        body: BlocBuilder<AccountsCubit, AccountsState>(
          builder: (context, state) {
            // Evaluating cubit states
            if (state is InitAccountsState || state is LoadingAccountsState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ResponseAccountsState) {
              final accounts = state.accounts;
              return _buildAccountList(accounts);
            } else {
              return const Center(child: Text('Error getting accounts'));
            }
          },
        ),
    );
  }

  // Private methods
  Widget _buildAccountList(List<Account> accounts) {
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


