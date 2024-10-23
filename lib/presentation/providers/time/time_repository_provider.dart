import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/data/dao/time_dao.dart';
import '../../../data/data_source/local/database_helper.dart';
import '../../../data/repositories/question_time_repository_impl.dart';

final timeRepositoryProvider =
    Provider((ref) => QuestionTimeRepositoryImpl(TimeDao(DatabaseHelper())));
