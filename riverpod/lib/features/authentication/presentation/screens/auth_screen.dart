import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'dart:async';
import '/shared/strings.dart';
import '/shared/constants.dart';
import '../providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../transactions/presentation/screens/transactions_screen.dart';
import '../../../accounts/presentation/screens/accounts_screen.dart';

// Auth Screen
class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {

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
          child: ref.watch(linkTokenProvider).when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
            data: (linkToken) => _buildOptions(linkToken),
          )
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
                    builder: ((context) => const AccountsScreen()),
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
                    builder: ((context) => const TransactionsScreen()),
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

  void _onSuccess(LinkSuccess event)        {
    // Get access token
    ref.read(accessTokenProvider(event.publicToken));

    // Set public token
    setState(() => _publicToken = event.publicToken);
  }

  void _onExit(LinkExit event) {
    setState(() => _error = event.error);
  }
}
