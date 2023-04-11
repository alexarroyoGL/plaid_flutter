import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../data/transaction.dart';
import '../data/account.dart';
import 'repository.dart';
import '../utils/constants.dart';
import '../utils/shared_preferences_helper.dart';

class PlaidRepository implements Repository {

  // Private properties
  Map<String, String> get _headers => {
    'content-type': 'application/json; charset=utf-8',
  };

  Map<String, dynamic> get _linkTokenBody => {
    'client_id': Constants.kClientId,
    'secret': Constants.kClientSecret,
    'client_name': "Alex Arroyo",
    'country_codes': ['US'],
    'language': 'en',
    'user': {
      'client_user_id': 'unique_user_id'
    },
    'products': ['auth', 'transactions']
  };

  // Overriding methods
  @override
  Future<String> getLinkToken() async {
    final results = await _postRequest(endpoint: Constants.kLinkTokenEndpoint, body: _linkTokenBody);
    return results[Constants.kLinkTokenAttribute];
  }

  @override
  Future<void> getAccessToken(String publicToken) async {
    if (publicToken.isNotEmpty) {
      Map<String, dynamic> body = {
        'client_id': Constants.kClientId,
        'secret': Constants.kClientSecret,
        "public_token": publicToken
      };

      final results = await _postRequest(endpoint: Constants.kTokenExchangeEndpoint, body: body);
      await SharedPreferencesHelper.setPreference(Constants.kAccessToken, results[Constants.kAccessTokenAttribute]);
    }
  }

  @override
  Future<List<Transaction>> fetchTransactions() async {
    final accessToken = await SharedPreferencesHelper.getPreference(Constants.kAccessToken);
    if (accessToken.isNotEmpty) {
      Map<String, dynamic> body = {
        'client_id': Constants.kClientId,
        'secret': Constants.kClientSecret,
        "access_token": accessToken,
        "count": 10
      };

      final results = await _postRequest(endpoint: Constants.kTransactionsEndpoint, body: body);
      return results['added'].map<Transaction>(Transaction.fromJson).toList(growable: false);
    }

    return <Transaction>[];
  }

  @override
  Future<List<Account>> fetchAccounts() async {
    final accessToken = await SharedPreferencesHelper.getPreference(Constants.kAccessToken);
    if (accessToken.isNotEmpty) {
      Map<String, String> body = {
        'client_id': Constants.kClientId,
        'secret': Constants.kClientSecret,
        "access_token": accessToken
      };

      final results = await _postRequest(endpoint: Constants.kAccountsEndpoint, body: body);
      return results['accounts'].map<Account>(Account.fromJson).toList(growable: false);
    }

    return <Account>[];
  }

  // Private methods
  Future<Map> _postRequest({required String endpoint, required Map<String, dynamic> body}) async {
    final uri = Uri.https(Constants.kHost, endpoint);
    final results = await http.post(uri, headers: _headers, body: jsonEncode(body));

    return json.decode(results.body);
  }

}