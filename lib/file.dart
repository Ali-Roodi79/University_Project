import 'package:flutter/material.dart';
import 'dart:math' as math;
class file extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return filestate();
  }

}
class filestate extends State<file>{
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: InteractiveViewer(
        minScale: 1.0,
        child: Container(
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/picture/file.png"),fit: BoxFit.cover)),
        ),
      ),
    );
  }

}