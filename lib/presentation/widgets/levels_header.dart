import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xpuzzle/utils/constants.dart';
import '../../data/models/remote/style_card_model.dart';

class LevelsHeader extends StatelessWidget{
  final String level;
  final String style;
  final int totalQuestions;
  final int correct;
  const LevelsHeader({super.key, required this.level,required this.totalQuestions, required this.style, required this.correct});
  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset("assets/images/svgs/header_background_complete.svg"),
        Padding(
          padding: EdgeInsets.only(left: context.screenWidth*0.1,right: context.screenWidth*0.11,top: 20),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(level,style: const TextStyle(fontWeight: FontWeight.w600),),
              Text("$totalQuestions/$correct",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              Text(style, style: const TextStyle(fontWeight: FontWeight.w600))
            ],

          ),
        ),

      ],
    );
  }

}