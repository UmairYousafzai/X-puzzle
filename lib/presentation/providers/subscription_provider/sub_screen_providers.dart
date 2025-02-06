import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:xpuzzle/domain/entities/states/subscription_state.dart';
import 'package:xpuzzle/domain/use_cases/subscription/buy_sub_product.dart';
import 'package:xpuzzle/domain/use_cases/subscription/get_sub_product.dart';
import 'package:xpuzzle/presentation/providers/subscription_provider/subscription_use_case_provider.dart';

class SubScreenNotifier extends StateNotifier<SubscriptionState> {
  final GetSubProduct getSubProduct;
  final BuySubProduct buySubProduct;

  SubScreenNotifier(this.getSubProduct, this.buySubProduct)
      : super(SubscriptionState());

  void getSubProducts() async {
    try {
      var products = await getSubProduct.execute();
      state = state.copyWith(products: products);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      state = state.copyWith(error: e.toString());
    }
  }

  void buySubscriptionProduct(ProductDetails product) async {
    var isSuccess = await buySubProduct.execute(product);

    if (isSuccess) {
      state = state.copyWith(success: "Subscribed Successfully");
    } else {
      state = state.copyWith(error: "Subscription Failed");
    }
  }

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}

final subScreenProvider =
    StateNotifierProvider<SubScreenNotifier, SubscriptionState>(
  (ref) => SubScreenNotifier(ref.watch(getSubProductsUseCaseProvider),
      ref.watch(buySubUseCaseProvider)),
);
