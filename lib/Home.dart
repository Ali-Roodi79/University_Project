import 'package:flutter/material.dart';
import 'package:circle_list/circle_list.dart';
import 'package:nullbox/Database/Core.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'dart:io';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nullbox/Widget/BackGroundVideo.dart';
import 'package:path/path.dart';
class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }

}
int tabindex=0;
List pic=["assets/picture/c1.png","assets/picture/c2.png","assets/picture/c1.png","assets/picture/c2.png","assets/picture/c1.png","assets/picture/c2.png"];
List pic2=["assets/picture/s2.jpg","assets/picture/s1.jpg","assets/picture/s2.jpg","assets/picture/s1.jpg","assets/picture/s2.jpg","assets/picture/s1.jpg"];
List pic3=["assets/picture/name2.png","assets/picture/name1.png","assets/picture/name2.png","assets/picture/name1.png","assets/picture/name2.png","assets/picture/name1.png"];
List pic4=["assets/picture/d2.png","assets/picture/d1.png","assets/picture/d2.png","assets/picture/d1.png","assets/picture/d2.png","assets/picture/d1.png"];
Color col=Colors.black;
class HomeState extends State<Home>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdata();
  }
 final controller=ScrollController();

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    Widget _Builditem(BuildContext context,int i){
      return SizedBox(
        width: size.width*0.7,
        height: size.height*0.4,
        child: Container(
          width: size.width*0.7,
          height: size.height*0.4,
          color: Colors.green,
          child: Center(
            child: Text("$i",style: TextStyle(color: Colors.black,fontSize: 25),),
          ),
        ),
      );
    }
    return AnimatedSwitcher(duration: Duration(seconds: 1),child: SizedBox(
      width: size.width,
      height: size.height,
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(pic2[tabindex]))),
        child: Stack(
          children: [
            Padding(padding: EdgeInsets.only(top: size.height*0.26),child: SizedBox(
              height: size.height*0.5,
              child: ScrollSnapList(
                listController: controller,
                itemBuilder: buildListItem,
                itemCount: pic.length,
                itemSize: 250,
                onItemFocus: (index) {
                  setState(() {
                    tabindex=index;
                  });
                },
                dynamicItemSize: true,
              ),
            ),),
            Positioned(child: SizedBox(
              width: size.width,
              height: size.height*0.4,
              child: Container(
                decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/picture/p1.png"),fit: BoxFit.cover)),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: size.height*0.03,right: size.width*0.4),child: SizedBox(
                      width: size.width*0.4,
                      height: size.height*0.1,
                      child: Container(
                        width: size.width*0.4,
                        height: size.height*0.1,
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage(pic3[tabindex]))),
                      ),
                    ),),
                    Padding(padding: EdgeInsets.only(top: size.height*0.01,),child: SizedBox(
                      width: size.width*0.8,
                      height: size.height*0.13,
                      child: Container(
                        width: size.width*0.8,
                        height: size.height*0.13,
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/picture/text.png"),fit: BoxFit.fitWidth)),
                      ),
                    ),),
                    AnimatedSwitcher(duration: Duration(seconds: 3),child: Padding(padding: EdgeInsets.only(top: size.height*0,),child: SizedBox(
                      width: size.width*0.4,
                      height: size.height*0.1,
                      child: GestureDetector(
                        child: Container(
                          width: size.width*0.4,
                          height: size.height*0.1,
                          decoration: BoxDecoration(image: DecorationImage(image: AssetImage(pic4[tabindex]),fit: BoxFit.fitWidth)),
                        ),
                        onTap: (){
                          Navigator.pushNamed(context, "/Home2");
                        },
                      ),
                    ),),)
                  ],
                ),
              ),
            ),top: size.height*0.62,)
          ],
        ),
      ),
    ),);
  }

 Widget buildListItem(BuildContext context, int index) {
    var size=MediaQuery.of(context).size;
   return SizedBox(
     width: size.width*0.7,
     height: size.height*0.5,
     child: ClipRRect(
       borderRadius: const BorderRadius.all(Radius.circular(10)),
       child: Container(
         margin: EdgeInsets.only(left: size.width*0.02,right: size.width*0.02),
         width: size.width*0.7,
         height: size.height*0.5,
         decoration: BoxDecoration(image: DecorationImage(image: AssetImage(pic[index]),fit: BoxFit.cover)),
       ),
     ),
   );
 }
 Widget buildListItem2(BuildContext context, int index) {
   var size=MediaQuery.of(context).size;
   return Padding(padding: EdgeInsets.only(right: size.width*0.4),child: SizedBox(
     width: size.width,
     height: size.height,
     child: ClipRRect(
       borderRadius: const BorderRadius.all(Radius.circular(10)),
       child: Container(
         width: size.width,
         height: size.height,
         decoration: BoxDecoration(image: DecorationImage(image: AssetImage(pic2[index]),fit: BoxFit.cover)),
       ),
     ),
   ),);
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