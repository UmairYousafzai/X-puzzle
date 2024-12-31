import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xpuzzle/data/data_source/local/shared_preference_helper.dart';
import 'package:xpuzzle/domain/entities/question.dart';

import '../../data/data_source/local/question_generator.dart';

Future<bool> generatePDF({
  bool isPPAndPS = false,
  bool isPPAndNS = false,
  bool isNPAndPS = false,
  bool isNPAndNS = false,
}) async {
  var user =
      SharedPreferencesHelper(await SharedPreferences.getInstance(), false)
          .getUser();

  final pdf = pw.Document();

  var img = await rootBundle.load('assets/images/print.png');
  var imageBytes = img.buffer.asUint8List();
  var imageBG = pw.MemoryImage(imageBytes);

  img = await rootBundle.load('assets/images/app_name.png');
  imageBytes = img.buffer.asUint8List();
  var imageAppName = pw.MemoryImage(imageBytes);

  var baloodaSemiBoldFont = await getBaloodaSemiBoldFont();
  var baloodaMediumBoldFont = await getBaloodaMediumFont();
  var boldBalooda = await getBaloodaBoldFont();

  final PdfColor blueColor = PdfColor.fromHex('#1E2D7C'); // HEX: #1E2D7C
  final orangeTransparentColor = PdfColor.fromHex("#F78C0C");

  var questions = await generatePositiveMultipleAndPositiveInteger(
      numberOfQuestion: 12,
      isPPAndPS: isPPAndPS,
      isPPAndNS: isPPAndNS,
      isNPAndPS: isNPAndPS,
      isNPAndNS: isNPAndNS);

  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Container(
            width: 615,
            height: 878,
            decoration: pw.BoxDecoration(
                image: pw.DecorationImage(image: imageBG, fit: pw.BoxFit.fill)),
            child: pw.Column(children: [
              pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(height: 20),
                          pw.Padding(
                            padding: const pw.EdgeInsets.only(left: 10),
                            child: pw.Image(imageAppName,
                                width: 191.w,
                                height: 69.h,
                                fit: pw.BoxFit.cover),
                          ),
                          pw.Padding(
                              padding: const pw.EdgeInsets.only(left: 27),
                              child: pw.Text(
                                "Essential Practice for Algebra\nFactoring (and a little bit fun)",
                                style: pw.TextStyle(
                                  font: baloodaSemiBoldFont,
                                  color: blueColor,
                                  fontSize: 15,
                                ),
                              )),
                        ]),
                    pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 10, top: 25),
                      child: pw.Container(
                        width: 241,
                        height: 120,
                        padding: const pw.EdgeInsets.all(10),
                        child: pw.Stack(children: [
                          pw.Opacity(
                            opacity: 0.5,
                            child: pw.Container(color: orangeTransparentColor),
                          ),
                          pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.SizedBox(height: 8),
                                pw.Padding(
                                    padding: const pw.EdgeInsets.only(left: 10),
                                    child: pw.Text(
                                      "Name: ${user!.firstName}",
                                      style: pw.TextStyle(
                                        font: baloodaMediumBoldFont,
                                        color: PdfColors.black,
                                        fontSize: 13,
                                      ),
                                    )),
                                pw.SizedBox(height: 2),
                                pw.Padding(
                                    padding: const pw.EdgeInsets.only(left: 10),
                                    child: pw.Text(
                                      "Level: ${getLevel(isPPAndPS: isPPAndPS, isPPAndNS: isPPAndNS, isNPAndPS: isNPAndPS, isNPAndNS: isNPAndNS)}",
                                      style: pw.TextStyle(
                                        font: baloodaMediumBoldFont,
                                        color: PdfColors.black,
                                        fontSize: 13,
                                      ),
                                    )),
                                pw.SizedBox(height: 2),
                                pw.Padding(
                                    padding: const pw.EdgeInsets.only(left: 10),
                                    child: pw.Text(
                                      "Result: ",
                                      style: pw.TextStyle(
                                        font: baloodaMediumBoldFont,
                                        color: PdfColors.black,
                                        fontSize: 13,
                                      ),
                                    )),
                              ])
                        ]),
                      ),
                    )
                  ]),
              pw.Padding(
                  padding: const pw.EdgeInsets.all(0),
                  child: pw.Container(
                      padding: const pw.EdgeInsets.all(10),
                      decoration: pw.BoxDecoration(
                          color: PdfColors.white,
                          borderRadius: pw.BorderRadius.circular(12)),
                      child:
                          // pw.Expanded(child:  pw.Column(
                          //     children: [
                          //       threeItemsInRow(
                          //           questions, orangeTransparentColor, boldBalooda,
                          //           0),
                          //       threeItemsInRow(
                          //           questions, orangeTransparentColor, boldBalooda,
                          //           1), threeItemsInRow(
                          //           questions, orangeTransparentColor, boldBalooda,
                          //           2), threeItemsInRow(
                          //           questions, orangeTransparentColor, boldBalooda,
                          //           3),
                          //     ]
                          // ) )

                          // pw.SizedBox(height: 520,width: 680)
                          pw.Wrap(
                              runSpacing: 0,
                              children: questions.map((item) {
                                // print("Question===> ${QuestionModel.copy(item).toJson()}");
                                return gridItemDesign(
                                    item, orangeTransparentColor, boldBalooda);
                              }).toList())))
            ]));
      }));

  // Save the PDF file
  return await savePdfToStorage(pdf);
}

Future<String> getExternalDocumentPath() async {
  // To check whether permission is given for this app or not.
  // var status = await Permission.storage.status;
  // if (kDebugMode) {
  //   print("request");
  // }
  // if (!status.isGranted) {
  //   // If not we will ask for permission first
  //   await Permission.storage.request();
  // }
  Directory _directory = Directory("");
  if (Platform.isAndroid) {
    // Redirects it to download folder in android
    _directory = Directory("/storage/emulated/0/Download");
  } else {
    _directory = await getApplicationDocumentsDirectory();
  }

  final exPath = _directory.path;
  if (kDebugMode) {
    print("Saved Path: $exPath");
  }
  await Directory(exPath).create(recursive: true);
  return exPath;
}

String getLevel({
  bool isPPAndPS = false,
  bool isPPAndNS = false,
  bool isNPAndPS = false,
  bool isNPAndNS = false,
}) {
  if (isPPAndPS) {
    return " 1";
  } else if (isPPAndNS) {
    return " 2";
  } else if (isNPAndPS) {
    return " 3";
  } else {
    return " 4";
  }
}

Future<bool> savePdfToStorage(
  pw.Document pdf,
) async {
  try {
    // Request permission to write to external storage
    // Get external directory path
    // Directory? directory = await getExternalStorageDirectory();
    //
    // // Create directory if it doesn't exist
    // String newPath = "";
    // List<String> folders = directory!.path.split("/");
    // for (int i = 1; i < folders.length; i++) {
    //   String folder = folders[i];
    //   if (folder != "Android") {
    //     newPath += "/$folder";
    //   } else {
    //     break;
    //   }
    // }
    // newPath = "$newPath/Documents";
    // directory = Directory(newPath);
    // if (!await directory.exists()) {
    //   await directory.create(recursive: true);
    // }

    var path = await getExternalDocumentPath();
    print("path =>>>>>>>>>>>>> $path");
    String fileString =
        "${path}/puzzler_${DateTime.now().millisecondsSinceEpoch}.pdf";
    print("file path =>>>>>>>>>>>>> $fileString");

    // Save the PDF file
    final file = File(fileString);
    await file.writeAsBytes(await pdf.save());
    if (Platform.isIOS) {
      OpenFile.open(file.path);
    }
    print("PDF saved at: ${file.path}");
    return true;
  } catch (e) {
    print("Error saving PDF: $e");
    return false;
  }
}

pw.Widget threeItemsInRow(List<Question> questions, PdfColor orangeColor,
    pw.Font boldBalooda, int columnCount) {
  var index = 0;
  if (columnCount == 1) {
    index = 3;
  } else if (columnCount == 2) {
    index = 6;
  } else if (columnCount == 3) {
    index = 9;
  }
  return pw.Row(children: [
    gridItemDesign(questions[index], orangeColor, boldBalooda),
    gridItemDesign(questions[index + 1], orangeColor, boldBalooda),
    gridItemDesign(questions[index + 2], orangeColor, boldBalooda)
  ]);
}

pw.Widget gridItemDesign(
    Question question, PdfColor orangeColor, pw.Font boldBalooda) {
  final svgImage = pw.SvgImage(
      svg:
          '''<svg width="65" height="64" viewBox="0 0 65 64" fill="none" xmlns="http://www.w3.org/2000/svg">
    <path d="M62.5503 2.13092L2.21376 62.4674" stroke="black" stroke-width="3" stroke-linecap="round"/>
    <path d="M2.21387 2.13092L62.5504 62.4674" stroke="black" stroke-width="3" stroke-linecap="round"/>
</svg>
''');

  return pw.Padding(
    padding: pw.EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    child: pw.Container(
      width: 120,
      height: 120,
      decoration: pw.BoxDecoration(
          borderRadius: pw.BorderRadius.circular(20),
          color: PdfColors.white,
          border: pw.Border.all(color: PdfColors.grey, width: 0.1)),
      child: pw.Column(
        mainAxisSize: pw.MainAxisSize.min,
        children: [
          pw.SizedBox(height: 15),
          pw.Padding(
            padding: const pw.EdgeInsets.only(top: 0),
            child: pw.Stack(
              alignment: pw.Alignment.center,
              children: [
                pw.Center(
                  child: svgImage,
                ),
                pw.Positioned(
                  bottom: 45,
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Container(
                        width: 15,
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(
                                bottom: pw.BorderSide(
                                    color: PdfColors.grey, width: 0.1)),
                            color: PdfColors.white),
                      ),
                      pw.SizedBox(width: 45),
                      pw.Container(
                        width: 15,
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(
                                bottom: pw.BorderSide(
                                    color: PdfColors.grey, width: 0.1)),
                            color: PdfColors.white),
                      ),
                    ],
                  ),
                ),
                pw.Column(
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Column(
                          mainAxisSize: pw.MainAxisSize.min,
                          children: [
                            pw.Text("x",
                                style: pw.TextStyle(
                                    color: orangeColor, font: boldBalooda)),
                            pw.Text(
                              question.topNum,
                              style: pw.TextStyle(font: boldBalooda),
                            )
                          ],
                        )
                      ],
                    ),
                    pw.SizedBox(height: 10),
                    pw.SizedBox(height: 10),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      children: [
                        pw.Text(
                          question.bottomNum,
                          style: pw.TextStyle(
                            font: boldBalooda,
                          ),
                        )
                      ],
                    ),
                    pw.Text("+",
                        style: pw.TextStyle(
                          color: orangeColor,
                          font: boldBalooda,
                        )),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<pw.Font> getBaloodaSemiBoldFont() async {
  final ByteData fontData =
      await rootBundle.load('assets/fonts/BalooDa2-Semibold.ttf');
  final Uint8List fontBytes = fontData.buffer.asUint8List();
  return pw.Font.ttf(fontBytes.buffer.asByteData());
}

Future<pw.Font> getBaloodaBoldFont() async {
  final ByteData fontData =
      await rootBundle.load('assets/fonts/BalooDa2-Bold.ttf');
  final Uint8List fontBytes = fontData.buffer.asUint8List();
  return pw.Font.ttf(fontBytes.buffer.asByteData());
}

Future<pw.Font> getBaloodaMediumFont() async {
  final ByteData fontData =
      await rootBundle.load('assets/fonts/BalooDa2-Medium.ttf');
  final Uint8List fontBytes = fontData.buffer.asUint8List();
  return pw.Font.ttf(fontBytes.buffer.asByteData());
}
