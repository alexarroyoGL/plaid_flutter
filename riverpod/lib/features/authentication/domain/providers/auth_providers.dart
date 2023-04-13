import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasource/auth_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';

// Auth data source provider
final authDataSourceProvider = Provider<AuthDataSourceImpl>((ref) => AuthDataSourceImpl());

// Auth repository provider
final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  final AuthDataSourceImpl dataSource = ref.watch(authDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
});