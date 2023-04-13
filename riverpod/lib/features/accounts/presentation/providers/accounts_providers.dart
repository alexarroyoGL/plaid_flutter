import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/domain/models/account/account.dart';
import '../../domain/providers/accounts_providers.dart';

// Accounts future provider
final accountsProvider = FutureProvider.autoDispose<List<Account>>((ref) {
  final accountsRepository = ref.watch(accountsRepositoryProvider);
  return accountsRepository.fetchAccounts();
});