part of 'transactions_cubit.dart';

@immutable
abstract class TransactionsState {}

class InitTransactionsState extends TransactionsState {}

class LoadingTransactionsState extends TransactionsState {}

class ErrorTransactionsState extends TransactionsState {}

class ResponseTransactionsState extends TransactionsState {

  // Properties
  final List<Transaction> transactions;

  // Constructor
  ResponseTransactionsState(this.transactions);

}
