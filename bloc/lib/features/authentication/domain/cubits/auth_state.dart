part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class InitAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class ErrorAuthState extends AuthState {}

class ResponseAuthState extends AuthState {

  // Properties
  final String linkToken;

  // Constructor
  ResponseAuthState(this.linkToken);

}
