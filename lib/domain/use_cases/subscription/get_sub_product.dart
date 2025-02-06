import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:xpuzzle/domain/repositories/subscription_repository.dart';

class GetSubProduct {
  final SubscriptionRepository subscriptionRepository;

  GetSubProduct(this.subscriptionRepository);

  Future<List<ProductDetails>> execute() async {
    return await subscriptionRepository.getProducts();
  }
}
