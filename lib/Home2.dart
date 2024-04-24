import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nullbox/Database/Core.dart';
import 'package:nullbox/Home4Level1.dart';
import 'package:nullbox/db.dart';
import 'package:nullbox/quiz.dart';
String Table_Charcater_Dialog_Level="";
String Table_Information_Level="";
String Table_Clue_Dialog_Level="";
String Table_Location_Level="";
String Table_Message_Level="";
var murder;

int Level=0;
class Home2 extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Home2State();
  }

}
class Home2State extends State<Home2>{
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/picture/p2.png"),fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height*0.15,
              ),
              GestureDetector(
                child: SizedBox(
                  width: size.width*0.8,
                  height: size.height*0.1,
                  child: Container(
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/picture/g1.png"))),
                  ),
                ),
                onTap: (){
                  //Navigator.pushNamed(context, "/Home3Level1");
                  TableName(1);

                },
              ),
              SizedBox(
                height: size.height*0.03,
              ),
              GestureDetector(
                child: SizedBox(
                  width: size.width*0.8,
                  height: size.height*0.1,
                  child: Container(
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/picture/g2.png"))),
                  ),
                ),
                onTap: (){
                  //Navigator.pushNamed(context, "/Home3Level2");
                  setState(() {
                    TableName(2);
                  });
                },
              ),
              SizedBox(
                height: size.height*0.03,
              ),
              GestureDetector(
                child: SizedBox(
                  width: size.width*0.8,
                  height: size.height*0.1,
                  child: Container(
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/picture/g3.png"))),
                  ),
                ),
                onTap: (){
                  TableName(3);
                  //Navigator.pushNamed(context, "/Home4Level3");
                },
              ),
              SizedBox(
                height: size.height*0.03,
              ),
              GestureDetector(
                child: SizedBox(
                  width: size.width*0.8,
                  height: size.height*0.1,
                  child: Container(
                    decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/picture/g4.png"))),
                  ),
                ),
                onTap: (){
                  TableName(4);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
  TableName(int level){
    Table_Charcater_Dialog_Level="Character_Dialog_Level$level";
    Table_Information_Level="Character_Information_Level$level";
    Table_Clue_Dialog_Level="Clue_Dialog_Level$level";
    Table_Location_Level="Location_Level$level";
    Table_Message_Level="Message_Level$level";
    Level=level;
    print(level);
    if(level==1){
      print(1);
      var man="CH16";
      print(man);
      murder=man;
    }else if(level==2){
      print(2);
      var man="CH07";
      print(man);
      murder=man;
    }else if(level==3){
      murder=="CH21";
    }
    arrest.clear();
    print(murder);
    NewGameCheck(level);
  }
  NewGameCheck(int id) async {
    var Save=await SQLHelper.getItems('Save_Game_Status',id);
    String condition=Save[0]['NewGame'];
    print("condition is");
    print(condition);
    if(condition=="0"){
      messenger(id);
    }else if(condition=="1"){
      setState(() {
        updateItem1(id, "0",context);
      });
    }
  }
  void messenger(int id){
    showDialog(context: context, builder: (BuildContext context){
      var size = MediaQuery
          .of(context)
          .size;
      return AlertDialog(
        backgroundColor: Colors.transparent,
        content: Container(
          width: size.width * 0.8,
          height: size.width * 0.5,
          child: SizedBox(
              width: size.width * 0.8,
              height: size.width * 0.8,
              child:Column(
                children: [
                  SizedBox(
                    height: size.height*0.04,
                  ),
                  Center(
                    child: Text("New Game Or Continue"),
                  ),
                  SizedBox(
                    height: size.height*0.04,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: size.width*0.01,
                      ),
                      GestureDetector(
                        child: SizedBox(
                          width: size.width*0.3,
                          height: size.height*0.1,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text("New Game",style: TextStyle(color: Colors.white,decoration: TextDecoration.none),),
                            ),
                          ),
                        ),
                        onTap: () async {
                          // await SQLHelper.deleteItem(id,"Save_Level_Data");
                          // Navigator.pushNamed(context, "/Home4");
                          // setState(() {
                          //   updateItem1(id, "0");
                          // });
                          clear();
                          Navigator.pushNamed(context, "/Home3Level$Level");
                        },
                      ),
                      SizedBox(
                        width: size.width*0.01,
                      ),
                      GestureDetector(
                        child: SizedBox(
                          width: size.width*0.3,
                          height: size.height*0.1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text("Continue",style: TextStyle(color: Colors.white,decoration: TextDecoration.none),),
                            ),
                          ),
                        ),
                        onTap: (){
                          Continue(id);
                        },
                      ),
                      SizedBox(
                        width: size.width*0.01,
                      ),
                    ],
                  )
                ],
              )
          ),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30),color: Colors.white,),
        ),
      );
    });
  }
  static Future<int> updateItem1(
      int id, String Status,BuildContext context) async {
    final db = await SQLHelper.db();

    final data = {
      'NewGame': Status,
    };
    final result =
    await db.update('Save_Game_Status', data, where: "id = ?", whereArgs: [id]);
    print(result);
    clear();
    print("updtated");
    Navigator.pushNamed(context, "/Home3Level$Level");
    return result;

  }
  static Future<int> Save(
      int id, String Level,String Clock,String CurrentLocation,String Messages) async {
    final db = await SQLHelper.db();
    final data = {
      'Level': Level,
      'Clock':Clock,
      'Current_Location':CurrentLocation,
      'Messages':Messages
    };
    final result =
    await db.update('Save_Level_Data', data, where: "id = ?", whereArgs: [id]);
    print(result);
    print("saved");
    return result;
  }
  Continue(int id) async {
    print("start");
    var data = await SQLHelper.getItems("Save_Level_Data",id);
    print("fetch data");
    print(data);
    Level=int.parse(data[0]["Level"]);
    print("rfetch level");
    Clock=data[0]["Clock"];
    var m=Clock.split(":");
    if(m[1]=="00"){
      setState(() {
        Clockdouble=double.parse(m[0]);
      });
    }else if(m[1]=="30"){
      setState(() {
        Clockdouble=double.parse(m[0]);
        Clockdouble=Clockdouble+0.5;
      });
    }
    print("fetch clock");
    MyLocation=data[0]["Current_Location"];
    print("fetch location");
    var mess=data[0]["Messages"];
    print("fetch message");
    ListOFMessage=jsonDecode(mess);
    print("Json Decode");
    print("Continue");
    print(Clock);
    print(MyLocation);
    print(mess);
    print(ListOFMessage);
    Navigator.pushNamed(context, "/Home4Level$Level");
  }


}
clear(){
  ListOFMessage.clear();
  Clock="07:00";
  Clockdouble=7.0;
  dt.clear();
  arrest.clear();
  MyLocation="Home";
  day=1;
  deadtimer=false;
  live=4;
}