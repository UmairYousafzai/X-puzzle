import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:xpuzzle/utils/constants.dart';

import '../../../data/models/remote/style_card_model.dart';
import '../../theme/colors.dart';
import '../../widgets/buttons/buttons.dart';

class ListStyleCard extends StatelessWidget {
  final StyleCardItemModel item;
  final void Function() onClicked;

  const ListStyleCard({super.key, required this.item,required this.onClicked});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 4,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          // Image Container on the left
          Container(
            width: context.screenWidth * 0.2, // Adjust the container width
            height: context.screenWidth * 0.2, // Adjust the container height to make it square
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: MColors().colorPrimary,
            ),
            // Center the image inside the container and resize it
            child: Center(
              child: SvgPicture.asset(
                item.imageSrc,
                width: context.screenWidth * 0.15, // Adjust image size
                height: context.screenWidth * 0.15, // Adjust image size
              ),
            ),
          ),

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
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: Colors.black87),
                  ),
                  const Gap(5),
                  Text(
                    item.sum,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .apply(color: Colors.black87),
                  ),
                  const Gap(20),
                  startButton(onClicked, context)
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
