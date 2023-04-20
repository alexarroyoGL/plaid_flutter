import '../../../../shared/domain/models/account/account.dart';
import '../../domain/repositories/accounts_repository.dart';
import '../datasource/accounts_datasource.dart';

class AccountsRepositoryImpl extends AccountsRepository {
  // Properties
  final AccountsDataSource dataSource;

  // Constructor
  AccountsRepositoryImpl(this.dataSource);

  // Overriding methods
  @override
  Future<List<Account>> fetchAccounts() {
    return dataSource.fetchAccounts();
  }

}