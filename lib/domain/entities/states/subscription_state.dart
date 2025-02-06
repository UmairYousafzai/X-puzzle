import 'package:in_app_purchase/in_app_purchase.dart';

class SubscriptionState {
  final List<ProductDetails> products;
  final bool isLoading; // Added for loading state
  final String? error; // Added for general errors
  final String? success; // Added for general errors

  SubscriptionState({
    this.products=const[],
    this.isLoading = true, // Initialize new fields
    this.error,
    this.success,
  });

  SubscriptionState copyWith({
    List<ProductDetails>? products,
    bool? isLoading,
    String? error,
    String? success,
  }) {
    return SubscriptionState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.error,
    );
  }
}
