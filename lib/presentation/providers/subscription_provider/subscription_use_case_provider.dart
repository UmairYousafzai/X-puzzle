import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/domain/use_cases/delete_question_latest_time.dart';
import 'package:xpuzzle/domain/use_cases/delete_question_time.dart';
import 'package:xpuzzle/domain/use_cases/get_question_by_type.dart';
import 'package:xpuzzle/domain/use_cases/get_time.dart';
import 'package:xpuzzle/domain/use_cases/store_time.dart';
import 'package:xpuzzle/domain/use_cases/subscription/buy_sub_product.dart';
import 'package:xpuzzle/domain/use_cases/subscription/get_sub_product.dart';
import 'package:xpuzzle/domain/use_cases/subscription/get_sub_purchase_stream.dart';
import 'package:xpuzzle/domain/use_cases/subscription/restore_sub_product.dart';
import 'package:xpuzzle/presentation/providers/subscription_provider/subscription_repository_provider.dart';
import 'package:xpuzzle/presentation/providers/time/time_repository_provider.dart';

final buySubUseCaseProvider =
    Provider((ref) => BuySubProduct(ref.watch(subscriptionRepositoryProvider)));
final getSubProductsUseCaseProvider =
    Provider((ref) => GetSubProduct(ref.watch(subscriptionRepositoryProvider)));
final restoreSubProductUseCaseProvider = Provider(
    (ref) => RestoreSubProduct(ref.watch(subscriptionRepositoryProvider)));
final getSubPurchaseUpdatesUseCaseProvider = Provider(
    (ref) => GetSubPurchaseStream(ref.watch(subscriptionRepositoryProvider)));
