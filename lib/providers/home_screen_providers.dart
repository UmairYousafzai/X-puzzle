

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:xpuzzle/models/remote/StylesModel.dart';
import 'package:flutter/material.dart';
import '../models/remote/style_card_model.dart';

final homeScreenStylesProvider= Provider<List<StyleCardItemModel>>((ref) {
  return  [
    StyleCardItemModel(
        style: Styles.style1,
        product: "Positive product",
        sum: "Positive sum",
        styleName: "Style1",
        imageSrc: "assets/images/style_1.png"),
    StyleCardItemModel(
        style: Styles.style2,
        product: "Positive product",
        sum: "Negative sum",
        styleName: "Style2",
        imageSrc: "assets/images/style_2.png"),
    StyleCardItemModel(
        style: Styles.style3,
        product: "Negative product",
        sum: "Positive sum",
        styleName: "Style3",
        imageSrc: "assets/images/style_3.png"),
    StyleCardItemModel(
        style: Styles.style4,
        product: "Negative product",
        sum: "Negative sum",
        styleName: "Style4",
        imageSrc: "assets/images/style_4.png")
  ];
});

