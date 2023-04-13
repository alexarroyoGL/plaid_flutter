import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/accounts_datasource.dart';
import '../../data/repositories/accounts_repository_impl.dart';

// Accounts data source provider
final accountsDataSourceProvider = Provider<AccountsDataSourceImpl>((ref) => AccountsDataSourceImpl());

// Accounts repository provider
final accountsRepositoryProvider = Provider<AccountsRepositoryImpl>((ref) {
  final AccountsDataSourceImpl dataSource = ref.watch(accountsDataSourceProvider);
  return AccountsRepositoryImpl(dataSource);
});