
import 'package:in_app_purchase/in_app_purchase.dart';

abstract class SubscriptionRepository {
  Future<List<ProductDetails>> getProducts();
  Future<bool> buySubscription(ProductDetails product);
  Future<void> restorePurchase( );
  Stream<List<PurchaseDetails>> purchaseStream();
}



