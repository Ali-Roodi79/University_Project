import 'package:flutter/material.dart';
import 'package:nullbox/Home2.dart';
import 'package:nullbox/Home4Level1.dart';
import 'package:nullbox/Widget/BackGroundVideo.dart';
class MessageList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return MessageState();
  }

}

class MessageState extends State<MessageList>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("list of the message is");
    print(ListOFMessage);
  }
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: SizedBox(
          width: size.width*0.3,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.message,color: Colors.black,size: 20,),
              Text("Messages",style: TextStyle(color: Colors.black,fontSize: 20),)
            ],
          ),
        ),
      ),
      body: ListView.builder(itemCount:ListOFMessage.length,itemBuilder: (BuildContext context,int index){
        // var ind=(index+1)*3-1;
        // print(ListOFMessage);
        // print("name is $name");
        var detail=ListOFMessage[index];
        var name=detail[2].toString();
        var nme=name.split('C');
        name="C"+nme[1];
        print(detail);
        return GestureDetector(
          child: ListTile(
              leading: SizedBox(
                width: size.width*0.2,
                height: size.width*0.2,
                child: Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),image: DecorationImage(image: AssetImage("assets/picture/All_Character/$name.png"))),
                ),
              ),
              trailing: const Icon(Icons.messenger_outlined,color: Colors.black,),
              title: Text("Message From $name")),
          onTap: (){
            if(detail[2].toString()=="CH27CH23"){
              messenger2(detail[1]);
            }else{
              messenger(name, detail[1]);
            }
            if(Level==3 && index==0){
              Navigator.pushNamed(context, "/file");
            }
          },
        );
      }),
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
                          child: Text(mess,style: TextStyle(color: Colors.black,decoration: TextDecoration.none,fontSize: 20),maxLines: 6,),
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

}