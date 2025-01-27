import 'package:xpuzzle/domain/repositories/firebase_repository.dart';

class ResetPasswordUseCase {
  final FirebaseRepository firebaseRepository;

  ResetPasswordUseCase(this.firebaseRepository);

  Future<void> execute(String email) {
    return firebaseRepository.sendPasswordResetEmail(email);
  }
}
