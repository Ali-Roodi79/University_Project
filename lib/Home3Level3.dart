import 'dart:async';
import 'dart:io';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nullbox/Widget/video2.dart';
import 'package:path/path.dart';
class Home3Level3 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Home3Level3State();
  }

}
class Home3Level3State extends State<Home3Level3>{
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
                child: VideoApp2(assets: "assets/film/introLevel3.mp4",),
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
                  child: Text("در این مرحله قتلی در داخل هواپیما در جریان است و شما از اتاق کنترل باید قاتل را پیدا کنید ، CH01 به قتل رسیده و CH30 کاراگاه خصوصی حاضر در هواپیما وضعیت را در دست کنترل گرفته است. زمان شما برای پیدا کردن قاتل یک روز است",style: TextStyle(color: Colors.white,decoration: TextDecoration.none,fontSize: size.width*0.03,fontFamily: 'kalame'),maxLines: 8,overflow: TextOverflow.ellipsis)),
            ),
          )

        ],
      ),
      onTap: (){
        Navigator.pushNamed(context, "/introlevel3");
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
