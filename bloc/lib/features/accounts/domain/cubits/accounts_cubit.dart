import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../shared/domain/models/account/account.dart';
import '../repositories/accounts_repository.dart';

part 'accounts_state.dart';

class AccountsCubit extends Cubit<AccountsState> {
  // Properties
  final AccountsRepository _repository;

  // Constructor
  AccountsCubit(this._repository) : super(InitAccountsState());

  // Methods
  Future<void> fetchAccounts() async {
    emit(LoadingAccountsState());
    final response = await _repository.fetchAccounts();
    emit(ResponseAccountsState(response));
  }

}
