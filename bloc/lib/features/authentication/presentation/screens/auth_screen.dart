import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plaid/features/accounts/domain/cubits/accounts_cubit.dart';
import 'package:plaid/features/accounts/presentation/screens/accounts_screen.dart';
import 'package:plaid/features/authentication/domain/cubits/auth_cubit.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'dart:async';
import '../../../accounts/data/datasource/accounts_datasource.dart';
import '../../../accounts/data/repositories/accounts_repository_impl.dart';
import '../../../transactions/data/datasource/transactions_datasource.dart';
import '../../../transactions/data/repositories/transactions_repository_impl.dart';
import '../../../transactions/domain/cubits/transactions_cubit.dart';
import '/shared/strings.dart';
import '/shared/constants.dart';
import '../../../transactions/presentation/screens/transactions_screen.dart';

// Auth Screen
class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  // Properties
  StreamSubscription<LinkExit>? _streamExit;
  StreamSubscription<LinkSuccess>? _streamSuccess;
  String? _publicToken;
  LinkError? _error;

  // Lifecycle methods
  @override
  void initState() {
    super.initState();

    _streamExit = PlaidLink.onExit.listen(_onExit);
    _streamSuccess = PlaidLink.onSuccess.listen(_onSuccess);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final cubit = context.read<AuthCubit>();
      cubit.getLinkToken();
    });
  }

  @override
  void dispose() {
    _streamExit?.cancel();
    _streamSuccess?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Image.asset(Constants.kPlaidLogo),
          leadingWidth: 100,
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Constants.kHeroImage),
                fit: BoxFit.fitHeight
            ),
          ),
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              // Evaluating cubit states
              if (state is InitAuthState || state is LoadingAuthState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ResponseAuthState) {
                final linkToken = state.linkToken;
                return _buildOptions(linkToken);
              } else {
                return const Center(child: Text('Error getting link token'));
              }
            },
          ),
        )
    );
  }

  // Private methods
  Widget _buildOptions(String linkToken) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextButton(
            onPressed: _publicToken == null ? () {
                // Initializing Plaid Link
                final LinkConfiguration configuration = LinkTokenConfiguration(token: linkToken);
                PlaidLink.open(configuration: configuration);
              } : null,
            child: Text(
              Strings.initializingLink,
              style: const TextStyle(fontSize: 10),
            )
          ),
          TextButton(
              onPressed: _publicToken != null ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) {
                      return BlocProvider(
                        create: (context) => AccountsCubit(AccountsRepositoryImpl(AccountsDataSourceImpl())),
                        child: const AccountsScreen(),
                      );
                    }),
                  ),
                );
              } : null,
              child: Text(
                Strings.accounts,
                style: const TextStyle(fontSize: 10),
              )
          ),
          TextButton(
              onPressed: _publicToken != null ? () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) {
                      return BlocProvider(
                        create: (context) => TransactionsCubit(TransactionsRepositoryImpl(TransactionsDataSourceImpl())),
                        child: const TransactionsScreen(),
                      );
                    }),
                  ),
                );
              } : null,
              child: Text(
                Strings.transactions,
                style: const TextStyle(fontSize: 10),
              )
          ),
        ],

      ),
    );
  }

  void _onSuccess(LinkSuccess event) {
    // Set public token
    setState(() => _publicToken = event.publicToken);

    // Get access token
    final cubit = context.read<AuthCubit>();
    cubit.getAccessToken(publicToken: event.publicToken);
  }

  void _onExit(LinkExit event) {
    setState(() => _error = event.error);
  }
}
