import 'package:flutter/material.dart';
import 'dart:math' as math;
class desktop extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return desktopstate();
  }

}
class desktopstate extends State<desktop>{
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
                image: AssetImage("assets/windows/desktop/bk.png"),fit: BoxFit.fitHeight
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
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/windows/desktop/na.png"),fit: BoxFit.fitHeight)),
              ),
            )),
            Positioned(
                right: size.width*0.1,
                top: size.width*0.1,
                child:
            GestureDetector(
              child: SizedBox(
                width: size.width*0.15,
                height: size.width*0.15,
                child: Container(
                  width: size.width*0.15,
                  height: size.width*0.15,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/windows/desktop/fo.png"))
                  ),
                ),
              ),
              onTap: (){
                Navigator.pushNamed(context, "/folder");
              },
            )
            ),
            Positioned(
                right: size.width*0.3,
                top: size.width*0.1,
                child:
                GestureDetector(
                  child: SizedBox(
                    width: size.width*0.15,
                    height: size.width*0.15,
                    child: Container(
                      width: size.width*0.15,
                      height: size.width*0.15,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage("assets/windows/desktop/re.png"))
                      ),
                    ),
                  ),
                  onTap: (){
                    Navigator.pushNamed(context, "/recycle");
                  },
                )
            ),
          ],
        ),
      ),
    );
  }

}