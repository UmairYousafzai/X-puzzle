import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xpuzzle/presentation/providers/shared_pref_provider.dart';
import 'package:xpuzzle/utils/constants.dart';

import '../../../data/models/remote/style_card_model.dart';
import '../../theme/colors.dart';

class GridStyleCard extends ConsumerStatefulWidget {
  final StyleCardItemModel styleItemModel;

  const GridStyleCard({super.key, required this.styleItemModel});

  @override
  _StyleCard createState() {
    return _StyleCard();
  }
}

class _StyleCard extends ConsumerState<GridStyleCard> {
  @override
  Widget build(BuildContext context) {
    final sharedPref= ref.watch(sharedPreferencesProvider);
    return Container(
      width: context.screenWidth * 0.445,
      height: context.screenHeight * 0.29,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(widget.styleItemModel.styleName,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: MColors().colorSecondaryBlueLight)),
          const SizedBox(height: 8),
          SvgPicture.asset(widget.styleItemModel.imageSrc),
          const SizedBox(height: 10),
          Text(
            widget.styleItemModel.product,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .apply(color: Colors.black87),
          ),
          Text(
            widget.styleItemModel.sum,
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
