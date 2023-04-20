import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/accounts_datasource.dart';
import '../../data/repositories/accounts_repository_impl.dart';
import '../repositories/accounts_repository.dart';

// Accounts data source provider
final accountsDataSourceProvider = Provider<AccountsDataSource>((ref) => AccountsDataSourceImpl());

// Accounts repository provider
final accountsRepositoryProvider = Provider<AccountsRepository>((ref) {
  final AccountsDataSource dataSource = ref.watch(accountsDataSourceProvider);
  return AccountsRepositoryImpl(dataSource);
});