import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:xpuzzle/domain/repositories/subscription_repository.dart';

class RestoreSubProduct {
  final SubscriptionRepository subscriptionRepository;

  RestoreSubProduct(this.subscriptionRepository);

  Future<void> execute(ProductDetails product) async {
    return await subscriptionRepository.restorePurchase();
  }
}
