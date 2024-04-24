import 'package:flutter/material.dart';
class mobile extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return mobilestate();
  }

}
class mobilestate extends State<mobile>{
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/picture/phone.jpg"),fit: BoxFit.cover)),
      ),
    );
  }

}