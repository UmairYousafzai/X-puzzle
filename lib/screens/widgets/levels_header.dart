

import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xpuzzle/models/remote/style_card_model.dart';
import 'package:xpuzzle/utils/constants.dart';

class LevelsHeader extends StatelessWidget{
  final String level;
  final Styles style;
  final int totalQuestions;
  final int correct;
  LevelsHeader({super.key, required this.level,required this.totalQuestions, required this.style, required this.correct});
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SvgPicture.asset("assets/images/svgs/header_background_complete.svg"),
           Padding(
            padding: EdgeInsets.only(left: scWidth(context)*0.1,right: scWidth(context)*0.11,top: 20),
            child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(level),
                  Text("${totalQuestions}/${correct}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  Text(style.name)
                ],

                      ),
            ),

      ],
    );
  }
  
}