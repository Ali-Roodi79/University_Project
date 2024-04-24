import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:nullbox/Home2.dart';

import 'Home4Level1.dart';
class quiz extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return quizstate();
  }

}
class quizstate extends State<quiz>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cons();
  }
  ScanResult? scanResult;
  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');
  var _aspectTolerance = 0.00;
  var _numberOfCameras = 0;
  var _selectedCamera = -1;
  var _useAutoFocus = true;

  var _autoEnableFlash = false;
  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];
  var res="";
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("arrest"),
        actions: [
          Padding(child:  GestureDetector(
            child: SizedBox(
              width: size.width*0.06,
              height: size.width*0.06,
              child: Center(child: Text("+",style: TextStyle(decoration: TextDecoration.none,fontSize: 25),),),
            ),
            onTap: (){
              if(live>0){
                scan();
              }
            },
          ),padding: EdgeInsets.only(right: size.width*0.05),)
        ],
      ),
      body: GridView.count(
          crossAxisCount: 4,
        children:List.generate(arrest.length, (index){
          var name=arrest[index];
          return GestureDetector(
            child: Container(
              width: size.width*0.25,
              height: size.height*0.15,
              decoration: BoxDecoration(color: Colors.greenAccent,borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  SizedBox(
                    width: size.width*0.15,
                    height: size.width*0.15,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          image: DecorationImage(image: AssetImage("assets/picture/All_Character/$name.png"))
                      ),
                    ),

                  ),
                  SizedBox(
                    height: size.height*0.01,
                  ),
                  Center(child: Text(name,style: TextStyle(color: Colors.black,decoration: TextDecoration.none),),)
                ],
              ),
            ),
            onTap: (){
              arresting(name);
            },
          );
        }),
      ),
    );
  }
  Future<void> scan() async {
    try {
      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );
      setState(() => scanResult = result);
    } on PlatformException catch (e) {
      setState(() {
        scanResult = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
        if(scanResult!=null){
          print(scanResult?.rawContent);
        }else{
          print("fuck");
        }
      });
    }
    setState(() {
      res=scanResult!.rawContent;
      arrest.add(res);
      clock(0.25);
    });

  }
  void arresting(String name){
    print("murder is $murder");
    if(live>=0){
      if(murder==name){
        showDialog(context: context, builder: (BuildContext context){
          var size = MediaQuery
              .of(context)
              .size;
          return SizedBox(
            width: size.width * 0.7,
            height: size.width * 0.6,
            child: Dialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Container(
                decoration: BoxDecoration(color: Colors.pinkAccent),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height*0.15,
                    ),
                    SizedBox(
                      width: size.width*0.6,
                      height: size.height*0.25,
                      child: Lottie.asset("assets/Json/successful.json"),
                    ),
                    SizedBox(
                      height: size.height*0.1,
                    ),
                    Text("Mission Successful",style: TextStyle(color: Colors.white,decoration: TextDecoration.none),),
                    SizedBox(
                      height: size.height*0.1,
                    ),
                    GestureDetector(
                      child: SizedBox(
                        width: size.width*0.6,
                        height: size.height*0.08,
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                          child: Center(
                            child: Text("Back To Home",style: TextStyle(color: Colors.pink,decoration: TextDecoration.none),),
                          ),
                        ),
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, "/Home2");
                      },
                    )
                  ],
                ),
              )
            ),
          );
        });

      }else{
        live--;
        if(live>0){
          showDialog(context: context, builder: (BuildContext context){
            var size = MediaQuery
                .of(context)
                .size;
            return SizedBox(
              width: size.width * 0.7,
              height: size.width * 0.6,
              child: Dialog(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.pinkAccent),
                    child: Column(
                      children: [
                        SizedBox(
                          height: size.height*0.15,
                        ),
                        SizedBox(
                          width: size.width*0.6,
                          height: size.height*0.25,
                          child: Container(
                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(50)),
                            child: Lottie.asset("assets/Json/break.json"),
                          ),
                        ),
                        SizedBox(
                          height: size.height*0.1,
                        ),
                        Text("You have $live more chances to find the killer.",style: TextStyle(color: Colors.white,decoration: TextDecoration.none),),
                        SizedBox(
                          height: size.height*0.1,
                        ),
                        GestureDetector(
                          child: SizedBox(
                            width: size.width*0.6,
                            height: size.height*0.08,
                            child: Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                                child: Center(
                                  child: Text("Back To Home",style: TextStyle(color: Colors.pink,decoration: TextDecoration.none),),
                                )
                            ),
                          ),
                          onTap: (){
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                  )
              ),
            );
          });
        }else{
          gameover();
        }
      }
    }
  }
  clock(double time){
    Clockdouble=Clockdouble+time;
    print(Clockdouble);
    var cl=Clockdouble.toString().split('.');
    print(cl);
    if(cl[1]=="25"){
      setState(() {
        Clock=cl[0]+":15";
      });
    }else if(cl[1]=="5"){
      setState(() {
        Clock=cl[0]+":30";
      });
    }else if(cl[1]=="75"){
      setState(() {
        Clock=cl[0]+":45";
      });
    }else if(cl[1]=="0"){
      setState(() {
        Clock=cl[0]+":00";
      });
    }
    if(Clock=="24:00"){
      Clock="7:00";
      Clockdouble=7.0;
      day++;
      if(day==3){
      }
    }
    print(Clock);
    MessageStructer(Clock);
  }
  void MessageStructer(String cl){
    if(mesLevel1.containsKey(cl)){
      var data=mesLevel1[cl];
      var me;
      if(data![0]==day){
        me=mes2Level1[data![1]];
        ExportSnackBar(data?[1],me?[1]);
        mes2Level1.remove(data[1]);
        print(mes2Level1);
      }
      // ExportSnackBar(data?[0],data?[1]);
      setState(() {
        List dt=[];
        dt.add(me[0]);
        dt.add(me[1]);
        dt.add(data[1]);
        ListOFMessage.add(dt);
        print(ListOFMessage);
      });
    }
  }
  ExportSnackBar(String name,String mes){
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: EdgeInsets.only(bottom: 50,left: 20),
          width: 350.0,
          duration: Duration(seconds: 4),
          content:GestureDetector(
            child: Container(
              padding: EdgeInsets.all(16),
              height: 90,
              width: 320,
              decoration: BoxDecoration(
                  color: Color(0xFF65BF00),
                  borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child:Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(name,style: TextStyle(fontSize: 25,color: Colors.white),),
                        Text("New Message",style: TextStyle(color: Colors.black,fontSize: 15),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    )),
                    SizedBox(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Icon(Icons.mail,color: Colors.black,size: 25,)
                      ],
                    ))
                  ],
                ),
              ),
            ),
            onTap: (){
              messenger(name,mes);
            },
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        )
    );
  }
  void messenger(String Name,String mess){
    showDialog(context: context, builder: (BuildContext context){
      var size = MediaQuery
          .of(context)
          .size;
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          width: size.width * 0.8,
          height: size.width * 0.8,
          child: SizedBox(
              width: size.width * 0.8,
              height: size.width * 0.8,
              child:Directionality(
                textDirection: TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height*0.01,
                      ),
                      SizedBox(
                        height: size.height*0.06,
                        child: Container(
                          width: size.height*0.06,
                          height: size.height*0.06,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),image: DecorationImage(image: AssetImage("assets/picture/All_Character/$Name.png"),fit: BoxFit.cover)),
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.01,
                      ),
                      Center(
                        child: Text(mess,style: TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: 20),),
                      ),
                      SizedBox(
                        height: size.height*0.00,
                      ),
                    ],
                  ),
                ),
              )
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Color(0xFF65BF00),),
        ),
      );
    });
  }
  cons(){
    if(Level==1){
      setState(() {
        mes=mesLevel1;
        mes2=mes2Level1;
      });

    }else if(Level==2){
      setState(() {
        mes=mesLevel2;
        mes2=mes2Level2;
      });
    }else if(Level==3){
      setState(() {
        mes=mesLevel3;
        mes2=mes2Level3;
      });
    }
  }

  gameover(){
    showDialog(context: context, builder: (BuildContext context){
      Timer(
          Duration(seconds: 3),(){
        Navigator.pushNamed(context, "/Home2");

      }
      );
      var size = MediaQuery
          .of(context)
          .size;
      return SizedBox(
        width: size.width * 0.7,
        height: size.width * 0.6,
        child: Dialog(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
            ),
            child: Container(
              decoration: BoxDecoration(color: Colors.pinkAccent),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height*0.15,
                  ),
                  SizedBox(
                    width: size.width*0.6,
                    height: size.height*0.25,
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(50)),
                      child: Lottie.asset("assets/Json/GameOver.json"),
                    ),
                  ),
                  SizedBox(
                    height: size.height*0.1,
                  ),
                  Text("Game over",style: TextStyle(color: Colors.white,decoration: TextDecoration.none),),
                  SizedBox(
                    height: size.height*0.1,
                  ),
                  GestureDetector(
                    child: SizedBox(
                      width: size.width*0.6,
                      height: size.height*0.08,
                      child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.white),
                          child: Center(
                            child: Text("Back To Home",style: TextStyle(color: Colors.pink,decoration: TextDecoration.none),),
                          )
                      ),
                    ),
                    onTap: (){
                      Navigator.pushNamed(context, "/Home2");
                    },
                  )
                ],
              ),
            )
        ),
      );
    });
  }

}
List arrest=[];
Map <String, List> mes={};
Map <String, List> mes2={};
Map<String , List> mesLevel1={
  "10:00":[1,"CH19CH23"],
  "14:00":[1,"CH27CH23"],
  "10:00":[2,"CH19CH19"],
  "15:00":[2,"CH19CH192"]

};
Map <String , List>mes2Level1={
  "CH19CH23":[false,"شخصیت 23 یک مامور خوب و با سابقه پلیس بوده که داشته روی پرونده یه باند مافیایی کار می کرده."],
  "CH27CH23":[false,"تمام فیلم های دوربین مداربسته پاک شده اند و تنها همین فیلم مونده"],
  "CH19CH19":[false,"دکتر به قتل رسید"],
  "CH19CH192":[false,"Ch06 توسط ماموران پلیس دستگیر شد و به دفتر پلیس در لوکیشن A منتقل شده است."],
  "CH09CH08":[true,""]

};
Map<String , List> mesLevel2={


};
Map <String , List>mes2Level2={
  "CH19CL08":[false,"این کارت بانکی متعلق به CH07 هست."]
};
Map<String , List> mesLevel3={
  "8:00":[1,"CH16CH16"],
  "11:00":[1,"CH19CH19"],
  "13:00":[1,"CH02CH02"],
  "15:00":[1,"CH19CH192"],
  "17:00":[1,"CH18CH18"],
  "21:00":[1,"CH23CH23"],


};
Map <String , List>mes2Level3={
  "CH16CH16":[false,"این پروند از توی سطل اشغال توالت فرودگاه پیدا شده، محتویات پرونده رو می تونید از لیست پیامک هاتون چک کنید :"],
  "CH19CH19":[false,"یک پیامک تهدید به قتل برای من ارسال شده بود ولی من ان را نادیده گرفتم لطفا گوشی من را چک کنید."],
  "CH02CH02":[false,"دکتر به قتل رسیده است."],
  "CH19CH192":[false,"سرباز به قتل رسیده است."],
  "CH18CH18":[false,"معلم به قتل رسیده است."],
  "CH23CH23":[false,"دانشجو به قتل رسیده است."],
};