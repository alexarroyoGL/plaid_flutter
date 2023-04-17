import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../shared/domain/models/transaction/transaction.dart';
import '../../data/repositories/transactions_repository_impl.dart';

part 'transactions_state.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  // Properties
  final TransactionsRepositoryImpl _repository;

  // Constructor
  TransactionsCubit(this._repository) : super(InitTransactionsState());

  // Methods
  Future<void> fetchTransactions() async {
    emit(LoadingTransactionsState());
    final response = await _repository.fetchTransactions();
    emit(ResponseTransactionsState(response));
  }

}
