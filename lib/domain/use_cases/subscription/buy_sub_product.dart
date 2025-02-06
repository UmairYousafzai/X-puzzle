import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:xpuzzle/domain/repositories/subscription_repository.dart';

class BuySubProduct {
  final SubscriptionRepository subscriptionRepository;

  BuySubProduct(this.subscriptionRepository);

  Future<bool> execute(ProductDetails product) async {
    return await subscriptionRepository.buySubscription(product);
  }
}
