import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/data/repositories/question_repository_impl.dart';

import '../../../data/dao/question_dao.dart';
import '../../../data/data_source/local/database_helper.dart';

final questionRepositoryProvider =
    Provider((ref) => QuestionRepositoryImpl(QuestionDao(DatabaseHelper())));
