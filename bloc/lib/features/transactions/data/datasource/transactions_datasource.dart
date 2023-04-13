import '../../../../shared/data/network_service.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/domain/models/transaction/transaction.dart';
import '../../../../shared/storage/shared_prefs_service.dart';

// Transactions data source
abstract class TransactionsDataSource {
  Future<List<Transaction>> fetchTransactions();
}

class TransactionsDataSourceImpl extends TransactionsDataSource {

  // Overriding methods
  @override
  Future<List<Transaction>> fetchTransactions() async {
    final accessToken = await SharedPrefsService.getPreference(Constants.kAccessToken);
    if (accessToken.isNotEmpty) {
      Map<String, dynamic> body = {
        'client_id': Constants.kClientId,
        'secret': Constants.kClientSecret,
        "access_token": accessToken,
        "count": 10
      };

      final results = await NetworkService.postRequest(endpoint: Constants.kTransactionsEndpoint, body: body);
      return results['added'].map<Transaction>(Transaction.fromJson).toList(growable: false);
    }

    return <Transaction>[];
  }

}