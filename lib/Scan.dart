
import 'dart:async';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:nullbox/Home2.dart';
import 'package:nullbox/Home4Level1.dart';
import 'package:nullbox/Home4Level3.dart';
import 'package:nullbox/db.dart';
import 'package:nullbox/deadtime.dart';
import 'package:nullbox/subtitle.dart';
ScanResult? scanResult2;
String res2="";
String dialog="";
class ScanPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return ScanPageState();
  }

}
class ScanPageState extends State<ScanPage> with SingleTickerProviderStateMixin{
  late AnimationController _animationController;
  late AnimationHandler _animationHandler;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationHandler = AnimationHandler(_animationController);
    cons();
    print(scanresult);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationHandler.dispose();
  }
  void _startAnimation() {
    setState(() {
      _animationHandler.startAnimation();
    });
  }

  void _stopAnimation() {
    setState(() {
      _animationHandler.stopAnimation();
    });
  }
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
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        //color: Colors.black,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/picture/scanbg.png"),fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: size.width*0.4,
              height: size.height*0.08,
            ),
            SizedBox(
              height: size.height*0.45,
              width: size.width*0.8,
            ),
            SizedBox(
              height: size.height*0.15,
            ),
            SizedBox(
              width: size.width,
              height: size.height*0.2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: size.width*0.1,
                  ),
                  GestureDetector(
                    child: SizedBox(
                      width: size.width*0.3,
                      height: size.height*0.1,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.deepOrange,borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text("مشخصات کارت",style: TextStyle(fontSize: 13,color: Colors.white,decoration: TextDecoration.none, fontFamily: 'kalame'),),
                        ),
                      ),
                    ),
                    onTap: (){
                      setState(() {
                        FetchInformationCharacter();
                      });
                      Navigator.pushNamed(context, "/Home4");

                    },
                  ),
                  SizedBox(
                    width: size.width*0.1,
                  ),
                  GestureDetector(
                    child: SizedBox(
                      width: size.width*0.3,
                      height: size.height*0.1,
                      child: Container(
                        decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          child: Text("اسکن کارت دیگر",style: TextStyle(fontSize: 13,color: Colors.white,decoration: TextDecoration.none,fontFamily: 'kalame'),),
                        ),
                      ),
                    ),
                    onTap: (){
                      _scanfinal("");
                    },
                    onDoubleTap: (){
                      print(scanresult);
                    },
                  ),
                  SizedBox(
                    width: size.width*0.1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<void> _scanfinal(String Des) async {
    try {
      print("scan222222222222222222222222");
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
      setState(() => scanResult2 = result);
    } on PlatformException catch (e) {
      setState(() {
        scanResult2 = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              ? 'The user did not grant the camera permission!'
              : 'Unknown error: $e',
        );
        if(scanResult2!=null){
          print(scanResult2?.rawContent);
        }
      });
    }
    setState(() {
      print("object");
      print("scan result is number1");
      print(scanresult);
      res2=scanResult2!.rawContent;
      scanresult.add(res2);
      print("scan result is number2");
      print(scanresult);
      FetchDialogCharacter(Table_Charcater_Dialog_Level,Table_Clue_Dialog_Level,scanresult[1]);
      Navigator.pushNamed(context, "/Home4Level$Level");
    });
  }
  FetchDialogCharacter( String Tablechar,String Tableclue ,String id) async {
    if(id[1]=="L" && scanresult[0][1]=="H"){
      print("CLue");
      var ID=id.split('CL');
      print(scanresult);
      int mainid=int.parse(ID[1]);
      print(mainid);
      var data = await SQLHelper.getItems(Tableclue,mainid);
      print("data");
      print(data);
      if(data[0][scanresult[0]]==null){
        dialog="غیر قابل دسترس";
      }else{
        dialog=data[0][scanresult[0]];
        String nam=scanresult[0]+scanresult[1];
        print("scan result is");
        print(nam);
        scanMessageStructer(nam);
        if(Level==3){
          print("Level3");
          play(dialog);
          search(dialog);
        }else{
          messenger(scanresult[0],dialog);
        }
      }
      print("any one here");
      print(dialog);
      messenger(scanresult[0],dialog);

    }else if(id[1]=="H" && scanresult[0][1]=="H"){
      var ID=id.split('CH');
      print(" number 1");
      print(scanresult);
      int mainid=int.parse(ID[1]);
      print(mainid);
      print(Tablechar);
      var data = await SQLHelper.getItems(Tablechar,mainid);
      print("data fetch");
      print("data");
      print(data);
      print("scanresult");
      print(" number 2");
      print(scanresult);
      if(data[0][scanresult[0]]==null){
        dialog="غیر قابل دسترس";
      }else{
        print("data");
        print(data);
        print("scanresult");
        print(scanresult);
        dialog=data[0][scanresult[0]];
        String nam=scanresult[0]+scanresult[1];
        print("scan result is");
        print(nam);
        scanMessageStructer(nam);
      }
      print(dialog);
      print("Level is $Level");
      if(Level==3){
        print("Level3");
        play(dialog);
        search(dialog);
      }else{
        messenger(scanresult[0],dialog);
      }

    }else{
      dialog="error in scan";
      print("error in scan");
      messenger(scanresult[0],dialog);
    }

  }
  void messenger( String Name,String mess){
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
              width: size.width * 0.57,
              height: size.width * 0.77,
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
                      SizedBox(
                        width: size.width*0.55,
                        child: Center(
                          child: Text(mess,style: TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: 20),),
                        ),
                      ),
                      SizedBox(
                        height: size.height*0.00,
                      ),
                    ],
                  ),
                ),
              )
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.white,),
        ),
      );
    });
  }
  FetchInformationCharacter() async {
    var data = await SQLHelper.getItems(Table_Information_Level,1);
    var location=await SQLHelper.getItems(Table_Location_Level,1);

    if(location[0][scanresult[0]]==MyLocation){
      if(data[0][scanresult[0]]==null){
        dialog="غیر قابل دسترس";
      }else{
        dialog=data[0][scanresult[0]];
      }
    }else if(location[0][scanresult[0]]==null){
      dialog="غیر قابل دسترس";
    }else if(location[0][scanresult[0]]=="ALL"){
      if(data[0][scanresult[0]]==null){
        dialog="غیر قابل دسترس";
      }else{
        dialog=data[0][scanresult[0]];
      }
    }else{
      dialog="در این مکان در دسترس نیست";
    }
    print(dialog);
    messenger(scanresult[0],dialog);
  }
  cons(){
    if(Level==1){
      setState(() {
        mes=mesLevel1;
        mes2=mes2Level1;
        print(mes2);
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
  void scanMessageStructer(String scan){
    print("here");
    if(mes2.containsKey(scan)){
      print("here");
      print("level is $Level");
      var data=mes2[scan];
      if(data![0]==true){
        deadlevel1();
      }else{
        print("here2");
        mes2Level1.remove(scan);
        Timer(
            Duration(minutes: 2,milliseconds: 900),(){
          ExportSnackBar(scan,data?[1]);
          //animation();
          _startAnimation();

        }
        );

      }
      // ExportSnackBar(data?[0],data?[1]);
      setState(() {
        List dt=[];
        dt.add(data[0]);
        dt.add(data[1]);
        dt.add(scan);
        ListOFMessage.add(dt);
        print(ListOFMessage);
      });
    }else{
      print("fasle");
    }
  }
  ExportSnackBar(String name,String mes){
    var nme=name.split('C');
    name="C"+nme[1];
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
  animation(){
    final HomeState nik=new HomeState();
    nik.animation();
  }
}
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
class AnimationHandler {
  late AnimationController _animationController;
  late Animation<double> _animation;

  AnimationHandler(this._animationController) {
    _animation = Tween<double>(begin: 90, end: 150).animate(_animationController);
  }

  void startAnimation() {
    _animationController.forward();
  }

  void stopAnimation() {
    _animationController.stop();
  }

  void dispose() {
    _animationController.dispose();
  }

  Animation<double> get animation => _animation;

  Widget animatedWidget(BuildContext context, bool Not,String Clock) {
    return AnimatedBuilder(animation: _animationController,builder: (BuildContext context,Widget? child){
      var size=MediaQuery.of(context).size;
      return Container(
        width: _animation.value,
        height: size.height*0.05,
        decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(40)),
        child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(child: SizedBox(
                  width: size.width*0.07,
                  height: size.width*0.07,
                  child: Icon(Icons.mail,color: Colors.white,size: 18,),
                ),visible: Not,),
                SizedBox(
                  width: size.width*0.04,
                ),
                Text(Clock,style: TextStyle(color: Colors.white,fontSize: 18,decoration: TextDecoration.none),),
                SizedBox(
                  width: size.width*0.04,
                ),
                Visibility(child: SizedBox(
                  width: size.width*0.07,
                  height: size.width*0.07,
                  child: Container(
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/picture/av.png")),borderRadius: BorderRadius.circular(40)),
                  ),
                ),visible: Not,)
              ],
            )
        ),
      );
    },);
  }
}
