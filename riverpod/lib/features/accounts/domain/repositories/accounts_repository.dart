import '../../../../shared/domain/models/account/account.dart';

abstract class AccountsRepository {
  Future<List<Account>> fetchAccounts();
}