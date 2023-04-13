import '../../../../shared/data/network_service.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/domain/models/account/account.dart';
import '../../../../shared/storage/shared_prefs_service.dart';

// Accounts data source
abstract class AccountsDataSource {
  Future<List<Account>> fetchAccounts();
}

class AccountsDataSourceImpl extends AccountsDataSource {

  // Overriding methods
  @override
  Future<List<Account>> fetchAccounts() async {
    final accessToken = await SharedPrefsService.getPreference(Constants.kAccessToken);
    if (accessToken.isNotEmpty) {
      Map<String, String> body = {
        'client_id': Constants.kClientId,
        'secret': Constants.kClientSecret,
        "access_token": accessToken
      };

      final results = await NetworkService.postRequest(endpoint: Constants.kAccountsEndpoint, body: body);
      return results['accounts'].map<Account>(Account.fromJson).toList(growable: false);
    }

    return <Account>[];
  }

}