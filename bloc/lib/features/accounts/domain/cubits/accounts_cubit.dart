import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../shared/domain/models/account/account.dart';
import '../../data/repositories/accounts_repository_impl.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  // Properties
  final AccountsRepositoryImpl _repository;

  // Constructor
  AccountsCubit(this._repository) : super(InitAccountsState());

  // Methods
  Future<void> fetchAccounts() async {
    emit(LoadingAccountsState());
    final response = await _repository.fetchAccounts();
    emit(ResponseAccountsState(response));
  }

}
