import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  // Properties
  final AuthRepository _repository;

  // Constructor
  AuthCubit(this._repository) : super(InitAuthState());

  // Methods
  Future<void> getLinkToken() async {
    emit(LoadingAuthState());
    final response = await _repository.getLinkToken();
    emit(ResponseAuthState(response));
  }

  Future<void> getAccessToken({required String publicToken}) async {
    await _repository.getAccessToken(publicToken: publicToken);
  }

}
