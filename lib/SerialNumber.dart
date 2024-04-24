import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_uuid/device_uuid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_session_manager/flutter_session_manager.dart';
import 'package:get_ip_address/get_ip_address.dart';
import 'package:lottie/lottie.dart';

bool internet=false;
class serialnumber extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return serianumberstate();
  }

}
class serianumberstate extends State<serialnumber>{
  var sessionManager = SessionManager();
  var subscription;
  String res="";
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
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        if(result.name=="none"){
          setState(() {
            internet=false;
          });
        }else{
          setState(() {
            internet=true;
          });
        }
      });
    });
    initPlatformState();
    //deside();
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.sizeOf(context);
    return (internet)?Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height*0.3,
              
            ),
            SizedBox(
              height: size.height*0.2,
              width: size.width*0.7,
              child: Lottie.asset("assets/Json/welcome.json"),
            ),
            SizedBox(
              height: size.height*0.3,
            ),
            GestureDetector(
              child: SizedBox(
                width: size.width*0.7,
                height: size.height*0.07,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(27)
                  ),
                  child: Center(
                    child: Text(
                      "Scan Serial Number",
                      style: TextStyle(color: Colors.white,decoration: TextDecoration.none),
                    ),
                  ),
                ),
              ),
              onTap: (){
                _scan("");
              },
            )
          ],
        ),
      ),
    ):Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width*0.9,
              height: size.height*0.5,
              child: Lottie.asset("assets/Json/NoInternet.json"),
            )
          ],
        ),
      ),

    );
  }
  chech()async{
    final connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        internet=true;
      });
    }
  }
  Future<void> _scan(String Des) async {
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
      servercheck(res);

    });

  }
  servercheck(String serial)async{
    var ipAddress = IpAddress(type: RequestType.text);
    var data=await ipAddress.getIpAddress();
    print("Serial Number is $serial");
    print("Device ID is $_uuid");
    print(data.toString());
    var ip=data.toString();
    //await sessionManager.set("serial", false);
    print("in");
    Map datasend = {
      'licenseKey': serial,
      'ipAddress': ip,
      'deviceCode':_uuid
    };

    String body = json.encode(datasend);
    var res=await http.post(Uri.parse('https://api.nullbox.torphin.com/api/License'),headers: {"Content-Type": "application/json"},body:body);
    print(res.statusCode);
    print(res.body);
    var accescstoken=json.decode(res.body)['data'];
    var resdata=json.decode(res.body)['success'];
    if(resdata==true){
      await sessionManager.set("token", accescstoken);
      //await sessionManager.set("serial", true);
      Navigator.pushNamed(context, "/Home");
    }else{

    }
    print(accescstoken);
    print(resdata);
    

  }
  dynamic astoken;
  deside()async{
    astoken = await SessionManager().get("token");
    print("astoken is $astoken");
    var params={
      "token":astoken,
      "deviceCode ":_uuid
    };
    final response = await http.get(Uri.parse('https://api.nullbox.torphin.com/api/License/$astoken/$_uuid'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $astoken',
    });
    var resdata=json.decode(response.body)['success'];
    print(resdata);
    if(resdata){
      Navigator.pushNamed(context, "/Home");
    }
  }
  String _uuid = 'Unknown';
  final _deviceUuidPlugin = DeviceUuid();
  Future<void> initPlatformState() async {
    String uuid;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      uuid = await _deviceUuidPlugin.getUUID() ?? 'Unknown uuid version';
    } on PlatformException {
      uuid = 'Failed to get uuid version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _uuid = uuid;
      print(_uuid);
    });
  }

}

