import 'package:flutter/material.dart';
import 'dart:math' as math;
late TextEditingController textedit1;
class windows extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return windowsstate();
  }

}
class windowsstate extends State<windows>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textedit1=TextEditingController();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Color(0xff75E603),
        child: Center(
          child: Transform.rotate(angle: math.pi / 2,
            child: SizedBox(
              width: size.width,
              height: size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: size.height*0.025,
                  ),
                  SizedBox(
                    height: size.height*0.22,
                    child: Container(
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/picture/log.png"))),
                    ),
                  ),
                  SizedBox(height: size.height*0.025,),
                  SizedBox(
                    width: size.width*0.7,
                    height: size.height*0.06,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Color(0xff436900),width: 5)
                      ),
                      child: Center(
                        child: SizedBox(
                          width: size.width*0.5,
                          height: size.height*0.05,
                          child: Container(
                            child: TextField(
                              controller: textedit1,
                              decoration: InputDecoration(hintText: "Password",hintStyle: TextStyle(fontSize: 8,color: Colors.black),fillColor: Colors.transparent),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height*0.03,),
                  GestureDetector(
                    child: SizedBox(
                      width: size.width*0.3,
                      height: size.height*0.03,
                      child: Container(
                          decoration: BoxDecoration(color: Color(0xff436900),borderRadius: BorderRadius.circular(30)),
                          child:Center(
                            child:  Text("Login",style: TextStyle(color: Colors.white,fontSize: 15,decoration: TextDecoration.none),),
                          )
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        if(textedit1.text == '1947'){
                          Navigator.pushNamed(context, "/desktop");
                        }else{
                          print("fuck");
                        }
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}