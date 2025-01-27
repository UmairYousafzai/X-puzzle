import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/use_cases/auth/get_auth_status_usecase.dart';
import '../../../domain/use_cases/auth/login_usecase.dart';
import '../../../domain/use_cases/auth/logout_usecase.dart';
import '../../../domain/use_cases/auth/password_reset_usecase.dart';
import '../../../domain/use_cases/auth/signup_usecase.dart';
import '../firebase/firebase_provider.dart';

final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  final repository = ref.watch(firebaseRepositoryProvider);
  return SignUpUseCase(repository);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(firebaseRepositoryProvider);
  return LoginUseCase(repository);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.watch(firebaseRepositoryProvider);
  return LogoutUseCase(repository);
});

final getAuthStatusUseCaseProvider = Provider<GetAuthStatusUseCase>((ref) {
  final repository = ref.watch(firebaseRepositoryProvider);
  return GetAuthStatusUseCase(repository);
});

final resetPasswordUseCaseProvider=Provider<ResetPasswordUseCase>((ref){
  final repository=ref.watch(firebaseRepositoryProvider);
  return ResetPasswordUseCase(repository);

});