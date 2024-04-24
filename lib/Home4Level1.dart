import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:audioplayers/audioplayers.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:nullbox/Data.dart';
import 'package:nullbox/Home.dart';
import 'package:nullbox/Home2.dart';
import 'package:nullbox/Scan.dart';
import 'package:nullbox/Widget/BackGroundVideo.dart';
import 'package:nullbox/quiz.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:nullbox/db.dart';
final StreamController<bool> streamControllerdead=new StreamController<bool>.broadcast();
int scan=0;
List dt=[];
int live=4;
AudioPlayer? _player;
bool deadtimer=false;
int day=1;
String Clock="07:00";
double Clockdouble=7.0;
String Messages="";
String destination="";
final player = _player = AudioPlayer();
List scanresult=[];
bool sbool=false;
String res="";
String MyLocation="Home";
class Home4Level1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }

}
var icewidth=false;
bool Not=false;

class HomeState extends State<Home4Level1> with TickerProviderStateMixin{
  late AnimationController _animationController;
  late AnimationHandler _animationHandler;
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

  late AnimationController controller;
  late Animation<double> aniamtion;
  late AnimationController controller2;
  late Animation<double> aniamtion2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animationHandler = AnimationHandler(_animationController);
    controller = new AnimationController(vsync: this,duration: Duration(seconds: 1));
    controller2 = new AnimationController(vsync: this,duration: Duration(milliseconds: 1500));
    aniamtion2=Tween(begin: 200.0,end:20.0).animate(new CurvedAnimation(parent: controller2, curve:Curves.easeInBack));
    aniamtion=Tween(begin: 90.0,end:150.0).animate(new CurvedAnimation(parent: controller, curve:Curves.easeInBack));
    //clear();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    streamControllerdead.close();
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
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return WillPopScope(child: Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/picture/Map_Level_1.png"),fit: BoxFit.cover)),
        child: Stack(
          children: [
            Positioned(child: Padding(
              padding: EdgeInsets.only(bottom: size.height*0.05),
              child: SizedBox(
                width: size.width*0.98,
                height: size.height*0.09,
                child: Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(color: Colors.white,
                      borderRadius: BorderRadius.circular(40)
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.0),
                    child: GNav(
                      backgroundColor: Colors.white,
                      color: Colors.black,
                      activeColor: Colors.white,
                      tabBackgroundColor: Colors.black,
                      iconSize: 24,
                      textSize: 24,
                      gap: 10,
                      onTabChange: (index){
                        setState(() {
                          icewidth=!icewidth;
                          print(icewidth);
                          if(index==1){
                            scan=0;
                            // _scan("");
                            _scanfinalCharacter("");
                            Navigator.pushNamed(context, "/ScanPage");
                          }else if(index==2){
                            print("Tab");
                            if(MyLocation=="A"){
                              Navigator.pushNamed(context, "/VR2Level1");
                            }else if(MyLocation == "D"){
                              print("D");
                              Navigator.pushNamed(context, "/VRLevel1");
                            }
                          }else if(index==3){
                            Navigator.pushNamed(context, "/Message");
                          }else{
                            if(icewidth){
                              setState(() {
                                clock(0.25);
                                controller.forward();
                                Timer(Duration(seconds: 1), (){
                                  setState(() {
                                    Not=true;
                                    // ExportSnackBar();
                                  });
                                });
                              });
                            }else{
                              setState(() {
                                Not=false;

                              });
                              Timer(Duration(milliseconds: 700), (){
                                controller.reverse();
                              });
                            }
                          }

                        });
                      },
                      padding: EdgeInsets.all(10),
                      tabs: [
                        GButton(icon: Icons.home,text: "Home",
                        ),
                        GButton(icon: Icons.search,text: "Scan",
                        ),
                        GButton(icon: Icons.panorama_photosphere_select,text: "VR",
                        ),
                        GButton(icon: Icons.mail,text: "Mail",
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),top: size.height*0.87,),
            Positioned(child: Visibility(
              child: Container(
                width: size.width*0.19,
                height: size.height*0.04,
                decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(50)),
                child:Center(
                    child: SlideCountdown(
                      duration: const Duration(minutes: 7),
                    )
                ),
              ),
              visible: deadtimer,
            ),top: size.height*0.11,left: size.width*0.4),
            Positioned(child:  GestureDetector(
              child: SizedBox(
                width: size.width*0.1,
                height: size.width*0.1,
                child: Container(
                  decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: SizedBox(
                      width: size.width*0.05,
                      height: size.width*0.05,
                      child: Image(image: AssetImage("assets/picture/save.png"),),
                    ),
                  ),
                ),
              ),
              onTap: (){
                Save(1, Level.toString(), Clock, MyLocation, ListOFMessage.toString());
              },
            ),top: size.height*0.05,left: size.width*0.1,),
            Positioned(child:  GestureDetector(
              child: SizedBox(
                width: size.width*0.1,
                height: size.width*0.1,
                child: Container(
                  decoration: BoxDecoration(color: Colors.lightBlue,borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: SizedBox(
                      width: size.width*0.05,
                      height: size.width*0.05,
                      child: Image(image: AssetImage("assets/picture/handcruff.png"),),
                    ),
                  ),
                ),
              ),
              onTap: (){
                Navigator.pushNamed(context, "/quiz");
              },
            ),top: size.height*0.05,right: size.width*0.1,),
            Padding(padding: EdgeInsets.only(bottom: size.height*0.85),child: Center(
              child: AnimatedBuilder(animation: controller,builder: (BuildContext context,Widget? child){
                return Container(
                  width: aniamtion.value,
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
              },),
            ),),
            Padding(padding: EdgeInsets.only(bottom: size.height*0.85),child: Center(child: _animationHandler.animatedWidget(context, Not, Clock),),),
            Positioned(child: GestureDetector(
              child: Container(
                width: size.width*0.14,
                height: size.width*0.14,
                decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(40)),
                child: Center(
                  child: (MyLocation=="D")?Container(
                    width: size.width*0.125,
                    height: size.width*0.125,
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(40)),
                    child: Center(
                        child: Padding(child: Lottie.asset("assets/Json/loc.json"),padding: EdgeInsets.only(bottom: 7),)
                    ),
                  ):Container(
                    width: size.width*0.125,
                    height: size.width*0.125,
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: Text("D",style: TextStyle(color: Colors.red,fontSize: 28,decoration: TextDecoration.none),),
                    ),
                  ),
                ),
              ),
              onTap: (){
                if(MyLocation!="D"){
                  Travel("D");
                }
              },
            ),top: size.height*0.18,left: size.width*0.3,),
            Positioned(child:GestureDetector(
              child:  Container(
                width: size.width*0.14,
                height: size.width*0.14,
                decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(40)),
                child: Center(
                  child: (MyLocation=="A")?Container(
                    width: size.width*0.125,
                    height: size.width*0.125,
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(40)),
                    child: Center(
                        child: Padding(child: Lottie.asset("assets/Json/loc.json"),padding: EdgeInsets.only(bottom: 7),)
                    ),
                  ):Container(
                    width: size.width*0.125,
                    height: size.width*0.125,
                    decoration: BoxDecoration(color: Colors.red,borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: Text("A",style: TextStyle(color: Colors.white,fontSize: 28,decoration: TextDecoration.none),),
                    ),
                  ),
                ),
              ),
              onTap: (){
                if(MyLocation!="A"){
                  Travel("A");
                }
              },
            ),top: size.height*0.7,right: size.width*0.1,),
            Positioned(child:GestureDetector(
              child:  Container(
                width: size.width*0.14,
                height: size.width*0.14,
                decoration: BoxDecoration(color: Colors.black,borderRadius: BorderRadius.circular(40)),
                child: Center(
                  child: (MyLocation=="B")?Container(
                    width: size.width*0.125,
                    height: size.width*0.125,
                    decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(40)),
                    child: Center(
                        child: Padding(child: Lottie.asset("assets/Json/loc.json"),padding: EdgeInsets.only(bottom: 7),)
                    ),
                  ):Container(
                    width: size.width*0.125,
                    height: size.width*0.125,
                    decoration: BoxDecoration(color: Colors.yellow,borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: Text("B",style: TextStyle(color: Colors.black,fontSize: 28,decoration: TextDecoration.none),),
                    ),
                  ),
                ),
              ),
              onTap: (){
                if(MyLocation!="B"){
                  Travel("B");
                }
              },
            ),top: size.height*0.4,right: size.width*0.25,),
            Positioned(child: GestureDetector(
              child: Container(
                width: size.width*0.14,
                height: size.width*0.14,
                decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(40)),
                child: Center(
                  child: (MyLocation=="Home")?Container(
                    width: size.width*0.125,
                    height: size.width*0.125,
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(40)),
                    child: Center(
                        child: Padding(child: Lottie.asset("assets/Json/loc.json"),padding: EdgeInsets.only(bottom: 7),)
                    ),
                  ):Container(
                    width: size.width*0.125,
                    height: size.width*0.125,
                    decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(40)),
                    child: Center(
                      child: Icon(Icons.home,color: Colors.white,size: 20,),
                    ),
                  ),
                ),
              ),
              onTap: (){
                if(MyLocation!="Home"){
                  Travel("Home");
                }
              },
            ),top: size.height*0.55,left: size.width*0.1,),

          ],
        ),
      ),
    ), onWillPop:()=> showExitPopup(context));
  }
  ExportSnackBar(String name,String mes){
    var n2=name;
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
              if(n2=="CH27CH23"){
                messenger2(mes);
              }else{
                messenger(name,mes);
              }
            },
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        )
    );
  }
  ExportSnackBar2(String mes){
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
                        Text("David Lynch",style: TextStyle(fontSize: 25,color: Colors.white),),
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
              messenger2(mes);
            },
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        )
    );
  }
  ExportMessage(bool Scanbool ,String Message,String Destination){
    destination=Destination;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: EdgeInsets.only(bottom: 50,left: 20),
          width: 350.0,
          duration: Duration(seconds: 4),
          content:Container(
            padding: EdgeInsets.all(16),
            height: 90,
            width: 320,
            decoration: BoxDecoration(
                color: Colors.greenAccent,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child:Center(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(Message,style: TextStyle(fontSize: 18,color: Colors.white ,decoration: TextDecoration.none),),
                      ],
                    )),
                    SizedBox(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        (Scanbool==false)?Icon(Icons.done,color: Colors.black,size: 25,):GestureDetector(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(color: Colors.amberAccent,borderRadius: BorderRadius.circular(40)),
                            child: Center(
                              child: Icon(Icons.search,color: Colors.black,size: 27,),
                            ),
                          ),
                          onTap: (){
                            print("check ticket");
                            setState(() {
                              _scanfinalLocation("");
                            });

                          },
                        )
                      ],
                    ))
                  ],
                ),
              ),
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        )
    );
  }
  Future<void> _scanfinalCharacter(String Des) async {
    scanresult.clear();
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
      print("2");
      scanresult.add(scanResult!.rawContent);
      print("scan result is");
      print(scanresult);
      scan++;
      clock(0.25);
    });

  }
  Future<void> _scanfinalLocation(String Des) async {
    scanresult.clear();
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
      print("2");
      scanresult.add(scanResult!.rawContent);
      CheckTicket(destination);
      scan++;
      clock(0.25);
    });

  }
  void Travel(String Destination){
    print("TRavel Func");
    setState(() {
      if(Destination=="A" && MyLocation=="Home"){
        String mes="Select Your Metro Ticket";
        ExportMessage(true, mes,Destination);
      }else if(Destination=="D" && MyLocation =="Home"){
        String mes="Select Your Metro Ticket";
        ExportMessage(true, mes,Destination);
      }else if (Destination=="D" && MyLocation =="A"){
        String mes="Select Your Helicopter Ticket";
        ExportMessage(true, mes,Destination);
      }else if(Destination=="A" && MyLocation =="D"){
        String mes="Select Your Helicopter Ticket";
        ExportMessage(true, mes,Destination);
      }else if(Destination=="B" && MyLocation=="Home"){
        String mes="Select Your Metro Ticket";
        ExportMessage(true, mes,Destination);
      }else if(Destination=="B" && MyLocation=="A"){
        String mes="Select Your Metro Ticket";
        ExportMessage(true, mes,Destination);
      }else if(Destination=="B" && MyLocation=="D"){
        String mes="Select Your Metro Ticket";
        ExportMessage(true, mes,Destination);
      }else if(Destination=="A" && MyLocation=="B"){
        String mes="Select Your Metro Ticket";
        ExportMessage(true, mes,Destination);
      }else if(Destination=="D" && MyLocation=="B"){
        String mes="Select Your Metro Ticket";
        ExportMessage(true, mes,Destination);
      }
    });
  }
  void CheckTicket(String Destination){
    print(scanresult);
    print(MyLocation);
    print(Destination);
    print(scanresult);
    if(scanresult[0]=="TicketMetro"&& Destination=="A"&& MyLocation=="Home"){
      setState(() {
        MyLocation="A";
      });
      ExportMessage(false, "Travel Successful", "A");
    }else if(scanresult[0]=="TicketMetro"&& Destination=="D"&& MyLocation=="Home"){
      setState(() {
        MyLocation="D";
      });
      ExportMessage(false, "Travel Successful", "A");
    }
    if(scanresult[0]=="TicketHel"&& Destination=="A" && MyLocation=="D"){
      setState(() {
        MyLocation="A";
      });
      ExportMessage(false, "Travel Successful", "A");
    }else if(scanresult[0]=="TicketHel"&& Destination=="D" && MyLocation=="A"){
      setState(() {
        MyLocation="D";
      });
      ExportMessage(false, "Travel Successful", "A");
    }else if(scanresult[0]=="TicketMetro"&& Destination=="B"&& MyLocation=="Home"){
      setState(() {
        MyLocation="B";
      });
      ExportMessage(false, "Travel Successful", "B");

    }else if(scanresult[0]=="TicketMetro"&& Destination=="B"&& MyLocation=="A"){
      setState(() {
        MyLocation="B";
      });
      ExportMessage(false, "Travel Successful", "B");

    }else if(scanresult[0]=="TicketMetro"&& Destination=="B"&& MyLocation=="D"){
      setState(() {
        MyLocation="B";
      });
      ExportMessage(false, "Travel Successful", "B");

    }else if(scanresult[0]=="TicketMetro"&& Destination=="D"&& MyLocation=="B"){
      setState(() {
        MyLocation="D";
      });
      ExportMessage(false, "Travel Successful", "D");

    }else if(scanresult[0]=="TicketMetro"&& Destination=="A"&& MyLocation=="B"){
      setState(() {
        MyLocation="A";
      });
      ExportMessage(false, "Travel Successful", "A");

    }

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
              width: size.width * 0.55,
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
  void messenger2(String mess){
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
              borderRadius: BorderRadius.circular(4)
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: double.infinity,
                height: size.width * 0.9,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color:Colors.white,),
              ),
              Positioned(child: Directionality(
                child: SizedBox(
                  width: size.width*0.55,
                  child: Center(
                    child: Text(mess,style: TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: 20),maxLines: 6,),
                  ),
                ),
                textDirection: TextDirection.rtl,
              ),top: size.height*0.01,),
              Positioned(child: SizedBox(
                width: size.width*0.65,
                height: size.height*0.2,
                child: VideoApp(assets: "assets/film/f1.mp4",),
              ),top: size.height*0.1)
            ],
          ),
        ),
      );
    });
  }
   Future<void> Save(
      int id, String Level,String Clock,String CurrentLocation,String Messages) async {
    final db = await SQLHelper.db();
    var data222 = await SQLHelper.getItems("Save_Level_Data",id);
    print(data222);
    String jsonTags = jsonEncode(ListOFMessage);
    print("Json ENcode");
    print(jsonTags);

    final data = {
      'Level': Level,
      'Clock':Clock,
      'Current_Location':CurrentLocation,
      'Messages':jsonTags
    };
    final result =
    await db.update('Save_Level_Data', data, where: "id = ?", whereArgs: [id]);
    print(result);
    print("saved");
    data222 = await SQLHelper.getItems("Save_Level_Data",id);
    print(data222);
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
        gameover();
      }else{
        Daying(context);
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
        dt.add(me[0]);
        dt.add(me[1]);
        dt.add(data[1]);
        ListOFMessage.add(dt);
        print(ListOFMessage);
      });
    }
  }

  gameover(){
    showDialog(context: context, builder: (BuildContext context){
      Timer(
          Duration(seconds: 6),(){
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
  // Daying(){
  //   showDialog(context: context, builder: (BuildContext context){
  //     var size = MediaQuery
  //         .of(context)
  //         .size;
  //     return SizedBox(
  //       width: size.width * 0.7,
  //       height: size.width * 0.45,
  //       child: Dialog(
  //           backgroundColor: Colors.transparent,
  //           shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(8)
  //           ),
  //           child: Container(
  //             decoration: BoxDecoration(color: Colors.white),
  //             child: Column(
  //               children: [
  //                 SizedBox(
  //                   height: size.height*0.1,
  //                 ),
  //                 SizedBox(
  //                   width: size.width*0.6,
  //                   height: size.height*0.35,
  //                   child: Container(
  //                     decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(50)),
  //                     child: Lottie.asset("assets/Json/day.json"),
  //                   ),
  //                 ),
  //                 SizedBox(
  //                   height: size.height*0.03,
  //                 ),
  //                 Text("Day $day Ended!",style: TextStyle(color: Colors.white,decoration: TextDecoration.none),),
  //                 SizedBox(
  //                   height: size.height*0.03,
  //                 ),
  //                 GestureDetector(
  //                   child: SizedBox(
  //                     width: size.width*0.6,
  //                     height: size.height*0.08,
  //                     child: Container(
  //                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.pinkAccent),
  //                         child: Center(
  //                           child: Text("Back To Home",style: TextStyle(color: Colors.white,decoration: TextDecoration.none),),
  //                         )
  //                     ),
  //                   ),
  //                   onTap: (){
  //                     Navigator.pop(context);
  //                   },
  //                 )
  //               ],
  //             ),
  //           )
  //       ),
  //     );
  //   });
  // }
  Daying(BuildContext context){
    var DD=day-1;
    var size=MediaQuery.of(context).size;
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          padding: EdgeInsets.only(bottom: size.height*0.25,left: 0),
          width: size.width*0.9,
          duration: Duration(seconds: 7),
          content:Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: [
                SizedBox(
                  height: size.height*0.1,
                ),
                SizedBox(
                  width: size.width*0.6,
                  height: size.height*0.35,
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(50)),
                    child: Lottie.asset("assets/Json/day.json"),
                  ),
                ),
                SizedBox(
                  height: size.height*0.03,
                ),
                Text("Day $DD Ended!",style: TextStyle(color: Colors.pink,decoration: TextDecoration.none),),
                SizedBox(
                  height: size.height*0.03,
                ),
                GestureDetector(
                  child: SizedBox(
                    width: size.width*0.6,
                    height: size.height*0.08,
                  ),
                  onTap: (){
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        )
    );
  }
  dead(){
    deadtimer=true;
    player.play(AssetSource("audio/alarm.mp3"));
    Timer(
        Duration(minutes: 6),(){
      player.pause();
    }
    );
  }

  clear(){
    setState(() {
      ListOFMessage.clear();
      Clock="7:00";
      Clockdouble=7.0;
      day=1;
      arrest.clear();
      dt.clear();
    });
  }
  animation(){
    animation2();
  }
  animation2(){
    controller.forward();
    Timer(Duration(seconds: 1), (){
      setState(() {
        Not=true;
        // ExportSnackBar();
      });
    });
  }



}

String Loc="";
String Mes="";
String Dio="";
String Sta="";
int Tim=0;


Map<String , List> mesLevel1={
  "10:00":[1,"CH19CH23"],
  "14:00":[1,"CH27CH23"],
  "11:00":[2,"CH19CH19"],
  "15:00":[2,"CH19CH192"]
};
Map <String , List>mes2Level1={
  "CH19CH23":[false,"شخصیت 23 یک مامور خوب و با سابقه پلیس بوده که داشته روی پرونده یه باند مافیایی کار می کرده."],
  "CH27CH23":[false,"تمام فیلم های دوربین مداربسته پاک شده اند و تنها همین فیلم مونده"],
  "CH19CH19":[false,"دکتر به قتل رسید"],
  "CH19CH192":[false,"Ch06 توسط ماموران پلیس دستگیر شد و به دفتر پلیس در لوکیشن A منتقل شده است."],
  "CH09CH08":[true,""]

};

List CH19List=["CH19","شخصیت 23 یک مامور خوب و با سابقه پلیس بوده که داشته روی پرونده یه باند مافیایی کار می کرده."];
List CH19List2=["CH19",""];
List CH20List=["CH20","دکتر به قتل رسیده است"];
List CH27List=["CH27","تمام فیلم های دوربین مداربسته پاک شده اند و تنها همین فیلم مونده"];
List ListOFMessage=[];
Future<bool> showExitPopup(context) async{
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Do you want to exit?"),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          print('yes selected');
                          player.pause();
                          Navigator.pushNamed(context, "/Home2");
                        },
                        child: Text("Yes"),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red.shade800),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('no selected');
                            Navigator.of(context).pop();
                          },
                          child: Text("No", style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      });
}