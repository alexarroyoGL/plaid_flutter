import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/auth_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../repositories/auth_repository.dart';

// Auth data source provider
final authDataSourceProvider = Provider<AuthDataSource>((ref) => AuthDataSourceImpl());

// Auth repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final AuthDataSource dataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
});