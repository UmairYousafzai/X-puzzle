import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/data/data_source/remote/subscription_helper.dart';
import 'package:xpuzzle/data/repositories/question_repository_impl.dart';
import 'package:xpuzzle/data/repositories/subscription_repository_impl.dart';

import '../../../data/dao/question_dao.dart';
import '../../../data/data_source/local/database_helper.dart';

final subscriptionRepositoryProvider =
    Provider((ref) => SubscriptionRepositoryImpl(SubscriptionHelper()));
