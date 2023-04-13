import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/providers/auth_providers.dart';

// Link token provider
final linkTokenProvider = FutureProvider.autoDispose<String>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.getLinkToken();
});

// Access token provider
final accessTokenProvider = FutureProvider.autoDispose.family<void, String>((ref, publicToken) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.getAccessToken(publicToken: publicToken);
});