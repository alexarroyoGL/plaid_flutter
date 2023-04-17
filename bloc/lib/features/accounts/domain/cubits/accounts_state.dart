part of 'accounts_cubit.dart';

@immutable
abstract class AccountsState {}

class InitAccountsState extends AccountsState {}

class LoadingAccountsState extends AccountsState {}

class ErrorAccountsState extends AccountsState {}

class ResponseAccountsState extends AccountsState {

  // Properties
  final List<Account> accounts;

  // Constructor
  ResponseAccountsState(this.accounts);

}
