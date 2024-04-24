import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nullbox/Widget/video2.dart';
import 'package:path/path.dart';
class Home3Level1 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Home3Level1State();
  }

}
class Home3Level1State extends State<Home3Level1>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return GestureDetector(
      child: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            color: Colors.white,
            child: Center(
              child: SizedBox(
                width: size.width * 1.1,
                height: size.height * 1.1,
                child: VideoApp2(assets: "assets/film/introLevel1.mp4",),
              ),
            ),
          ),
          Positioned(
            top: size.height*0.8,
            left: size.width*0.1,
            child:SizedBox(
              width: size.width*0.8,
              child:Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text("در این مرحله جنازه CH23 در ایستگاه مترو در لوکیشن D پیدا شده و CH28 بعد از رویت جنازه با پلیس تماس گرفته است. دفتر مقتول نیز در لوکیشن A واقع شده است. پرونده را اغاز کنید و قاتل را تحویل قانون دهید. برای حل این پرونده بر اساس ساعت بازی 2 روز زمان دارید.",style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: size.width*0.04,fontFamily: 'kalame'),maxLines: 6,overflow: TextOverflow.ellipsis,)),
            ),
          )

        ],
      ),
      onTap: (){
        Navigator.pushNamed(context, "/Home4Level1");
      },
    );
  }
  fetchdata() async {
    final dbpath= await sql.getDatabasesPath();
    print(dbpath);
    final path=join(dbpath,"Character.db");
    final exist=await sql.databaseExists(path);
    print(exist);
    if(exist==false){
      try{
        await Directory(dirname(path)).create(recursive: true);
      }catch(_){}
      ByteData data=await rootBundle.load(join("assets","Character.db"));
      List<int> bytes=data.buffer.asInt8List(data.offsetInBytes,data.lengthInBytes);
      await File(path).writeAsBytes(bytes,flush: true);
      await sql.openDatabase(path);
      print("db copied");
    }
  }
}
