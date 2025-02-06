import 'package:flutter/foundation.dart';
import 'package:in_app_purchase_platform_interface/src/types/product_details.dart';
import 'package:in_app_purchase_platform_interface/src/types/purchase_details.dart';
import 'package:xpuzzle/data/data_source/remote/subscription_helper.dart';
import 'package:xpuzzle/data/models/local/question_model.dart';
import 'package:xpuzzle/domain/entities/question.dart';
import 'package:xpuzzle/domain/repositories/question_repository.dart';

import '../../domain/repositories/subscription_repository.dart';
import '../dao/question_dao.dart';
import '../data_source/local/database_helper.dart';

class SubscriptionRepositoryImpl extends SubscriptionRepository {
  final SubscriptionHelper subscriptionHelper;

  SubscriptionRepositoryImpl(this.subscriptionHelper);

  @override
  Future<bool> buySubscription(ProductDetails product) async {
   return await subscriptionHelper.buySubscription(product);
  }

  @override
  Future<List<ProductDetails>> getProducts() async {
    return await subscriptionHelper.initializeAndGetProduct();
  }

  @override
  Stream<List<PurchaseDetails>> purchaseStream() =>
      subscriptionHelper.purchaseUpdates;

  @override
  Future<void> restorePurchase() => subscriptionHelper.restorePurchases();
}
