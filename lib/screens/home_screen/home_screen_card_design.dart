import 'package:flutter/material.dart';
import 'package:xpuzzle/theme/colors.dart';

import '../../models/remote/style_card_model.dart';

class StyleCard extends StatelessWidget {
  final StyleCardItemModel styleItemModel;

  const StyleCard({Key? key, required this.styleItemModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(styleItemModel.styleName, style: Theme.of(context).textTheme.titleMedium?.copyWith(
           color: MColors().colorSecondaryBlueLight
          )),
          SizedBox(height: 8),
          Image.asset(styleItemModel.imageSrc),
          SizedBox(height: 10),
          Text(
            styleItemModel.product,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .apply(color: Colors.black87),
          ),
          Text(
            styleItemModel.sum,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .apply(color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
