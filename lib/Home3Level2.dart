import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nullbox/Widget/video2.dart';
import 'package:path/path.dart';
class Home3Level2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Home3Level2State();
  }

}
class Home3Level2State extends State<Home3Level2>{
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
                child: VideoApp2(assets: "assets/film/introLevel2.mp4",),
              ),
            ),
          ),
          Positioned(
            top: size.height*0.8,
            left: size.width*0.11,
            child: SizedBox(
              width: size.width*0.8,
              child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text("در این مرحله جنازه بی جان CH18 در خانه ی خود در مکان A پیدا شده و CH10 با پلیس تماس گرفته است. پرونده را آغاز کنید و قاتل را تحویل قانون بدهید CH19 در این پرونده به شما کمک خواهد کرد. برای حل این پرونده بر اساس ساعت بازی 3 روز زمان دارید.",style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: size.width*0.04,fontFamily: 'kalame'),maxLines: 6,overflow: TextOverflow.ellipsis,)),
            ),
          )

        ],
      ),
      onTap: (){
        Navigator.pushNamed(context, "/Home4Level2");
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
