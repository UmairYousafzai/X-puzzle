import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:xpuzzle/domain/repositories/subscription_repository.dart';

class GetSubPurchaseStream {
  final SubscriptionRepository subscriptionRepository;

  GetSubPurchaseStream(this.subscriptionRepository);

  Stream<List<PurchaseDetails>> execute() =>
      subscriptionRepository.purchaseStream();
}
