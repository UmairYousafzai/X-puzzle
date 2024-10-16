import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../data/models/remote/style_card_model.dart';
import '../../theme/colors.dart';
import '../../widgets/buttons/buttons.dart';


class HomeScreen2CardDesign extends StatelessWidget {
  final StyleCardItemModel item;

  const HomeScreen2CardDesign({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3),
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

          const Gap(5),
          // Column for text information
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                item.styleName,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: MColors().colorSecondaryOrangeDark,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(
                    item.product,
                    style: Theme.of(context).textTheme.bodySmall!.apply(color: Colors.black87),
                  ),
                  const Gap(5),
                  Text(
                    item.sum,
                    style: Theme.of(context).textTheme.bodySmall!.apply(color: Colors.black87),
                  ),
                  const Gap(10),

                  startButton(() {

                  }, context)
                ],
              ),

            ],
          ),
        ],
      ),
    );
  }
}
