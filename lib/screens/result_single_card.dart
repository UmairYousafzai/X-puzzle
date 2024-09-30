
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xpuzzle/theme/colors.dart';

class ResultSingleCard extends StatelessWidget{
  final bool isCorrect;
  ResultSingleCard({super.key, required this.isCorrect});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4,right: 4,top: 10,bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(isCorrect?"Correct":"wrong",style:Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: isCorrect?MColors().colorSecondaryBlueDark:MColors().colorSecondaryOrangeDark,
                  fontWeight: FontWeight.bold
              )),
              Padding(
                padding: const EdgeInsets.only(top:3.0),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    SvgPicture.asset("assets/images/svgs/cross_sign.svg"),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                Text("x",style: TextStyle(
                                    color: MColors().colorSecondaryOrangeDark,
                                    fontWeight: FontWeight.bold
                                )),
                                Text("10",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            )
                          ],
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: MColors().colorSecondaryBlueLighter
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0,top: 3,right: 5,bottom: 3),
                                child: Text("84",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MColors().colorSecondaryBlueDark
                                ),),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: MColors().colorSecondaryBlueLighter
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5.0,top: 3,right: 5,bottom: 3),
                                child: Text("85",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: MColors().colorSecondaryBlueDark
                                ),),
                              ),
                            ),

                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("10",style: TextStyle(fontWeight: FontWeight.bold),)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}