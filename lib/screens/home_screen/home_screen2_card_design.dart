import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/theme/colors.dart';
import 'package:xpuzzle/utils/constants.dart';

import '../../models/remote/style_card_model.dart';
import '../widgets/buttons/buttons.dart';

class HomeScreen2CardDesign extends StatelessWidget {
  final StyleCardItemModel item;

  const HomeScreen2CardDesign({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: const EdgeInsets.all(6),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          // Image on the left
          Image.asset(
            item.imageSrc,
            width: 60, // Adjust size as needed
            height: 60, // Adjust size as needed
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10), // Space between image and text

          // Column for text information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  item.styleName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: MColors().colorOrangeDark,
                  ),
                ),
                const SizedBox(height: 4),
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      item.product,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black87,fontSize: 10),
                    ),
                    Text(
                      item.sum,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black87,fontSize: 10),
                    ),

                    startButton(() {}, context)
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
