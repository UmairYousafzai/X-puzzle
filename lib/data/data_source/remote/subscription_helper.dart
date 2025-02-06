import 'package:in_app_purchase/in_app_purchase.dart';

import '../../../utils/constants.dart';

class SubscriptionHelper {

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  bool _isAvailable = false;

  Stream<List<PurchaseDetails>> get purchaseUpdates => _inAppPurchase.purchaseStream;

  Future<List<ProductDetails>> initializeAndGetProduct() async {
    _isAvailable = await _inAppPurchase.isAvailable();
    print("In-app purchases are available $_isAvailable");
    if (!_isAvailable) {
      throw Exception('In-app purchases are not available.');
    }

   return await _loadProducts();
  }

  Future<List<ProductDetails>> _loadProducts() async {
    ProductDetailsResponse response = await _inAppPurchase.queryProductDetails(kSubProductIDS);
    print("product response ===>  ${response.productDetails}");
    if (response.notFoundIDs.isNotEmpty) {
      throw Exception('Some products were not found: ${response.notFoundIDs}');
    }
    return response.productDetails;
  }


  Future<bool> buySubscription(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
   return await _inAppPurchase.buyConsumable(purchaseParam: purchaseParam);
  }

  Future<void> verifyAndAcknowledgePurchase(PurchaseDetails purchase) async {
    if (purchase.status == PurchaseStatus.purchased) {

      // Acknowledge the purchase
      if (purchase.pendingCompletePurchase) {
        await _inAppPurchase.completePurchase(purchase);
      }
    }
  }

  // Restore purchases (optional)
  Future<void> restorePurchases() async {
    await _inAppPurchase.restorePurchases();
  }
}