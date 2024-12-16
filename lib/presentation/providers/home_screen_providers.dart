import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/remote/style_card_model.dart';

final homeScreenStylesProvider = Provider<List<StyleCardItemModel>>((ref) {
  return [
    StyleCardItemModel(
        style: Styles.style1,
        product: "Positive product",
        sum: "Positive sum",
        styleName: "Level 1",
        imageSrc: "assets/icons/svg/style_one.svg"),
    StyleCardItemModel(
        style: Styles.style2,
        product: "Positive product",
        sum: "Negative sum",
        styleName: "Level 2",
        imageSrc: "assets/icons/svg/style_two.svg"),
    StyleCardItemModel(
        style: Styles.style3,
        product: "Negative product",
        sum: "Positive sum",
        styleName: "Level 3",
        imageSrc: "assets/icons/svg/style_three.svg"),
    StyleCardItemModel(
        style: Styles.style4,
        product: "Negative product",
        sum: "Negative sum",
        styleName: "Level 4",
        imageSrc: "assets/icons/svg/style_four.svg")
  ];
});

enum ViewType { list, grid }

class HomeScreenViewNotifier extends StateNotifier<Map<String, dynamic>> {
  HomeScreenViewNotifier()
      : super({"view_type": ViewType.list, "is_loading": false, "style": 0});

  void toggleView() {
    if (state["view_type"] == ViewType.list) {
      state = {...state, "view_type": ViewType.grid};
    } else {
      state = {...state, "view_type": ViewType.list};
    }
  }

  void setLoading(bool isLoading) {
    state = {...state, "is_loading": isLoading};
  }

  void setStyle(int style) {
    state = {...state, "style": style};
  }
}

final homeViewTypeProvider =
    StateNotifierProvider<HomeScreenViewNotifier, Map<String, dynamic>>(
  (ref) => HomeScreenViewNotifier(),
);
