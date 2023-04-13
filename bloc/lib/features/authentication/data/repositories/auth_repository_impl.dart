import '../../domain/repositories/auth_repository.dart';
import '../datasource/auth_datasource.dart';

class AuthRepositoryImpl extends AuthRepository {

  // Properties
  final AuthDataSourceImpl dataSource;

  // Constructor
  AuthRepositoryImpl(this.dataSource);

  // Overriding methods
  @override
  Future<String> getLinkToken() {
    return dataSource.getLinkToken();
  }

  @override
  Future<void> getAccessToken({required String publicToken}) {
    return dataSource.getAccessToken(publicToken: publicToken);
  }

}