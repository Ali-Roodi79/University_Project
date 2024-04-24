import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nullbox/Widget/video2.dart';
bool next=false;

class Splash extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SpalshState();
  }
}

class SpalshState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nav(context);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height*0.2,
          ),
          Center(
            child: SizedBox(
              width: size.width * 1.1,
              height: size.height * 0.6,
              child: VideoApp2(assets: "assets/film/splash.mp4",),
            ),
          ),
          Visibility(child: GestureDetector(
            child: Container(
              width: size.width*0.6,
              height: size.height*0.07,
              decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(25)),
              child: Center(
                child: Text("Start",style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: 20),),
              ),
            ),
            onTap: (){
              Navigator.pushNamed(context, "/Home");
            },
          ),visible: next,)

        ],
      ),
    );
  }

  nav(BuildContext context) {
    Timer(
        Duration(seconds: 7,milliseconds: 900),(){
      setState(() {
        next=true;
        print("hi");
      });
    }
    );
  }

}