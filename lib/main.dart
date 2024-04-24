//main.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:nullbox/mobile.dart';
import 'package:nullbox/vr4Level2.dart';
import 'package:nullbox/vrLevel1.dart';
import 'package:nullbox/Camera.dart';
import 'package:nullbox/Home3Level2.dart';
import 'package:nullbox/Home3Level3.dart';
import 'package:nullbox/Home4Level2.dart';
import 'package:nullbox/Home4Level3.dart';
import 'package:nullbox/Level3Intro.dart';
import 'package:nullbox/Messages.dart';
import 'package:nullbox/Scan.dart';
import 'package:nullbox/SerialNumber.dart';
import 'package:nullbox/file.dart';
import 'package:nullbox/pic.dart';
import 'package:nullbox/quiz.dart';
import 'package:nullbox/vr2Level1.dart';
import 'package:nullbox/vr2Level2.dart';
import 'package:nullbox/vr3Level2.dart';
import 'package:nullbox/vrLevel2.dart';
import 'package:nullbox/windows.dart';
import 'package:nullbox/windows/desktop.dart';
import 'package:nullbox/windows/folder.dart';
import 'package:nullbox/windows/pdf1.dart';
import 'package:nullbox/windows/pdf2.dart';
import 'package:nullbox/windows/recycle.dart';

import 'db.dart';
import 'Home.dart';
import 'Home2.dart';
import 'Home3Level1.dart';
import 'Home4Level1.dart';
import 'Data.dart';
import 'model.dart';
import 'model2.dart';
import 'package:nullbox/Splash.dart';
import 'vr.dart';
import 'vr2.dart';
StreamController<int> streamController = StreamController();
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Remove the debug banner
    debugShowCheckedModeBanner: false,
    initialRoute: "/splash",
    routes: {
    "/VRLevel1":(context)=>VrLevel1page(),
      "/mobile":(context)=>mobile(),
      "/Home" :(context)=>Home(),
    "/Home2" :(context)=>Home2(),
    "/Home3Level1" :(context)=>Home3Level1(),
      "/Home3Level2" :(context)=>Home3Level2(),
      "/Home3Level3" :(context)=>Home3Level3(),
    "/Home4Level1" : (context)=>Home4Level1(),
      "/Home4Level2":(context)=>Home4Level2(),
      "/Home4Level3":(context)=>Home4Level3(),
    "/VR" : (context)=> Vrpage(),
    "/VR2" : (context)=>Vrpage2(),
      "/ScanPage" : (context)=>ScanPage(),
      "/Message":(context)=>MessageList(),
      "/quiz":(context)=>quiz(),
      "/pdf1":(context)=>pdfone(),
      "/desktop":(context)=>desktop(),
      "/folder":(context)=>folder(),
      "/recycle":(context)=>recycle(),
      "/pdf2":(context)=>pdftwo(),
      "/splash":(context)=>Splash(),
      "/serialnumber":(context)=>serialnumber(),
      "/pic":(context)=>picture(),
      "/model1":(context)=>model(),
      "/model2":(context)=>model2(),
      "/camera":(context)=>camera(),
      "/file":(context)=>file(),
      "/introlevel3":(context)=>introlevel3(),
      "/VR2Level1":(context)=>VrLevel1page2(),
      "/VRLevel2":(context)=>VrLevel2page(),
      "/VR2Level2":(context)=>Vr2Level2page(),
      "/VR3Level2":(context)=>Vr3Level2page(),
      "/VR4Level2":(context)=>Vr4Level2page(),
      "/windows":(context)=>windows(),
    },
    );
  }
}