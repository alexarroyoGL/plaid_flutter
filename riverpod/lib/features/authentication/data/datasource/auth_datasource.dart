import 'dart:async';
import '../../../../shared/data/network_service.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/storage/shared_prefs_service.dart';

// Authentication data source
abstract class AuthDataSource {
  Future<String> getLinkToken();
  Future<void> getAccessToken({required String publicToken});
}

class AuthDataSourceImpl extends AuthDataSource {

  // Overriding methods
  @override
  Future<String> getLinkToken() async {
    Map<String, dynamic> body = {
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

    final results = await NetworkService.postRequest(endpoint: Constants.kLinkTokenEndpoint, body: body);
    return results[Constants.kLinkTokenAttribute];
  }

  @override
  Future<void> getAccessToken({required String publicToken}) async {
    if (publicToken.isNotEmpty) {
      Map<String, dynamic> body = {
        'client_id': Constants.kClientId,
        'secret': Constants.kClientSecret,
        "public_token": publicToken
      };

      final results = await NetworkService.postRequest(endpoint: Constants.kTokenExchangeEndpoint, body: body);
      await SharedPrefsService.setPreference(Constants.kAccessToken, results[Constants.kAccessTokenAttribute]);
    }
  }

}