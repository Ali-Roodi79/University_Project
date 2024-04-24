import 'package:flutter/material.dart';
import 'dart:math' as math;
class recycle extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return recyclestate();
  }

}
class recyclestate extends State<recycle>{
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/windows/recyclebin/bk.png"),fit: BoxFit.fitHeight
            )
        ),
        child: Stack(
          children: [
            Positioned(right: size.width*0.92,child: SizedBox(
              height: size.height,
              width: size.width*0.08,
              child: Container(
                height: size.height,
                width: size.width*0.08,
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/windows/recyclebin/na.png"),fit: BoxFit.fitHeight)),
              ),
            )),
            Positioned(
                right: size.width*0.02,
                top: size.width*0.08,
                child:
                GestureDetector(
                  child: SizedBox(
                    width: size.width*0.1,
                    height: size.width*0.13,
                    child: Container(
                      width: size.width*0.1,
                      height: size.width*0.13,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/windows/folder/back.png"))
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, "/desktop");
                  },
                )
            ),
            Positioned(
                right: size.width*0.2,
                top: size.width*0.3,
                child:
                GestureDetector(
                  child: SizedBox(
                    width: size.width*0.15,
                    height: size.width*0.15,
                    child: Container(
                      width: size.width*0.15,
                      height: size.width*0.15,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/windows/recyclebin/fi.png"))
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, "/pdf2");
                  },
                )
            ),
          ],
        ),
      ),
    );
  }

}