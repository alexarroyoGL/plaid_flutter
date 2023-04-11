import 'package:flutter/material.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'dart:async';
import '/utils/strings.dart';
import '/utils/constants.dart';
import '/data/plaid_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/ui/transactions_screen.dart';
import '/ui/accounts_screen.dart';

// Repository provider
final plaidRepositoryProvider = Provider<PlaidRepository>((ref) {
  return PlaidRepository();
});

// Link token future provider
final linkTokenFutureProvider = FutureProvider.autoDispose<String>((ref) {
  // Get repository from the provider above
  final plaidRepository = ref.watch(plaidRepositoryProvider);
  // Call method that returns a Future<linkToken>
  return plaidRepository.getLinkToken();
});

// App Widget
class PlaidApp extends ConsumerStatefulWidget {
  const PlaidApp({Key? key}) : super(key: key);

  @override
  ConsumerState<PlaidApp> createState() => _PlaidAppState();
}

class _PlaidAppState extends ConsumerState<PlaidApp> {

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
    // Getting the value of the provider
    final linkTokenAsync = ref.watch(linkTokenFutureProvider);

    return Scaffold(
        appBar: AppBar(
            title: Text(Strings.appTitle)
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Constants.kHeroImage),
                fit: BoxFit.fitHeight
            ),
          ),
          child: linkTokenAsync.when(
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
      alignment: Alignment.bottomRight,
      child: Column(
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

  void _onSuccess(LinkSuccess event) async {
    // Get access token
    final repoProvider = ref.watch(plaidRepositoryProvider);
    repoProvider.getAccessToken(event.publicToken);

    // Set public token
    setState(() => _publicToken = event.publicToken);
  }

  void _onExit(LinkExit event) {
    setState(() => _error = event.error);
  }
}
