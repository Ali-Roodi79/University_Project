import 'package:flutter/material.dart';
class picture extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return picstate();
  }

}
class picstate extends State<picture>{
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Image(image: AssetImage("assets/picture/phone.jpg"),fit: BoxFit.cover,),
    );
  }

}