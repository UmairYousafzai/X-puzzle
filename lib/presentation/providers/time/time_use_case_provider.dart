import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/domain/use_cases/get_time.dart';
import 'package:xpuzzle/domain/use_cases/store_time.dart';
import 'package:xpuzzle/presentation/providers/time/time_repository_provider.dart';

final storeTimeUseCaseProvider =
    Provider((ref) => StoreTime(ref.watch(timeRepositoryProvider)));
final getTimeUseCaseProvider =
    Provider((ref) => GetTime(ref.watch(timeRepositoryProvider)));
