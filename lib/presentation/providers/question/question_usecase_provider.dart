import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/domain/use_cases/check_is_pp_and_ps_exist_use_case.dart';
import 'package:xpuzzle/domain/use_cases/get_questions.dart';
import 'package:xpuzzle/domain/use_cases/store_questions.dart';
import 'package:xpuzzle/presentation/providers/question/question_repository_provider.dart';

import '../../../domain/use_cases/check_np_and_ns_exist_use_case.dart';
import '../../../domain/use_cases/check_np_and_ps_exist_use_case.dart';
import '../../../domain/use_cases/check_pp_and_ns_exist_use_case.dart';
import '../../../domain/use_cases/update_questions.dart';

final storeQuestionUseCaseProvider =
    Provider((ref) => StoreQuestions(ref.watch(questionRepositoryProvider)));
final getQuestionUseCaseProvider =
    Provider((ref) => GetQuestions(ref.watch(questionRepositoryProvider)));
final updateQuestionUseCaseProvider =
    Provider((ref) => UpdateQuestion(ref.watch(questionRepositoryProvider)));
final isPPAndPSUseCaseProvider = Provider(
    (ref) => CheckIsPpAndPsExist(ref.watch(questionRepositoryProvider)));
final isPPAndNSUseCaseProvider =
    Provider((ref) => CheckPpAndNsExist(ref.watch(questionRepositoryProvider)));
final isNPAndPSUseCaseProvider =
    Provider((ref) => CheckNpAndPsExist(ref.watch(questionRepositoryProvider)));
final isNPAndNSUseCaseProvider =
    Provider((ref) => CheckNpAndNsExist(ref.watch(questionRepositoryProvider)));
