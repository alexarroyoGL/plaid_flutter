import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../data/repositories/auth_repository_impl.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  // Properties
  final AuthRepositoryImpl _repository;

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
