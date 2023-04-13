abstract class AuthRepository {
  Future<String> getLinkToken();
  Future<void> getAccessToken({required String publicToken});
}