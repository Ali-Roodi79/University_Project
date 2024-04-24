import 'package:flutter/material.dart';

class introlevel3 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return introlevel3state();
  }


}

class introlevel3state extends State<introlevel3>{
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height*0.15,
            ),
            Directionality(textDirection: TextDirection.rtl,
                child:Text("اشخاص حاضر در پرواز",style: TextStyle(color: Colors.black,fontSize: 25,fontFamily: 'kalame',decoration: TextDecoration.none),)
            ),
            SizedBox(
              height: size.height*0.05,
            ),
            Directionality(textDirection: TextDirection.rtl,
                child:Text(" CH03 خبرنگار",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'kalame',decoration: TextDecoration.none),)
            ),
            SizedBox(
              height: size.height*0.03,
            ),
            Directionality(textDirection: TextDirection.rtl,
                child:Text(" CH02 دکتر",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'kalame',decoration: TextDecoration.none),)
            ),
            SizedBox(
              height: size.height*0.03,
            ),
            Directionality(textDirection: TextDirection.rtl,
                child:Text(" CH12 بازیگر",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'kalame',decoration: TextDecoration.none),)
            ),
            SizedBox(
              height: size.height*0.03,
            ),
            Directionality(textDirection: TextDirection.rtl,
                child:Text("  CH19سرباز",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'kalame',decoration: TextDecoration.none),)
            ),
            SizedBox(
              height: size.height*0.03,
            ),
            Directionality(textDirection: TextDirection.rtl,
                child:Text(" CH14دستیار پزشک",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'kalame',decoration: TextDecoration.none),)
            ),
            SizedBox(
              height: size.height*0.03,
            ),
            Directionality(textDirection: TextDirection.rtl,
                child:Text("  CH23دانشجو",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'kalame',decoration: TextDecoration.none),)
            ),
            SizedBox(
              height: size.height*0.03,
            ),
            Directionality(textDirection: TextDirection.rtl,
                child:Text(" CH01وکیل به قتل رسیده",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'kalame',decoration: TextDecoration.none),)
            ),
            SizedBox(
              height: size.height*0.03,
            ),
            Directionality(textDirection: TextDirection.rtl,
                child:Text("CH30 کاراگاه خصوصی",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'kalame',decoration: TextDecoration.none),)
            ),
            SizedBox(
              height: size.height*0.03,
            ),
            Directionality(textDirection: TextDirection.rtl,
                child:Text("CH21 فروشنده",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'kalame',decoration: TextDecoration.none),)
            ),
            SizedBox(
              height: size.height*0.03,
            ),
            Directionality(textDirection: TextDirection.rtl,
                child:Text("CH18 معلم",style: TextStyle(color: Colors.black,fontSize: 15,fontFamily: 'kalame',decoration: TextDecoration.none),)
            ),
            SizedBox(
              height: size.height*0.06,
            ),
            GestureDetector(
              child: SizedBox(
                width: size.width*0.4,
                height: size.height*0.07,
                child: Container(
                  decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(35)),
                  child: Center(
                    child: Text("Start",style: TextStyle(fontSize: 20,color: Colors.white,decoration: TextDecoration.none),),
                  ),
                ),
              ),
              onTap: (){
                Navigator.pushNamed(context, "/Home4Level3");
              },
            )

          ],
        ),
      ),
    );
  }

}