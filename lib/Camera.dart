import 'package:flutter/material.dart';
import 'dart:math' as math;
class camera extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return camerastate();

  }

}
class camerastate extends State<camera>{
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/picture/camera2.png"),fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(child: Transform.rotate(angle: math.pi /2,child: SizedBox(
              width: size.width*0.58,
              height: size.height*0.203,
              child: InteractiveViewer(
                minScale: 1,
                child: Image.asset("assets/picture/camera.png",fit: BoxFit.cover,),
              ),
            ),),top: size.height*0.34,left: size.width*0.10,)
          ],
        ),
      ),
    );
  }

}