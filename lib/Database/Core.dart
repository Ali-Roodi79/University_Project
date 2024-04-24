import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
String mixcode="CH0CH0";
String location="PL-D";
String Message="Hello";
double Time=2.30;
String Staus="null state";
String Dialog="hey hey";
class CoreDatabase {
  Map<String, dynamic>toMap(){
    return{
      'mixcode': mixcode,
      'location': location,
      'message': Message,
      'time': Time,
      'dialog': Dialog,
      'status': Staus,
    };
  }
  Future <Database>database() async {
    print(await getDatabasesPath());
    return openDatabase(
      join(await getDatabasesPath() ,'NullBoxCase.db'),
      onCreate: (db, version)async{
        await db.execute("CREATE TABLE caseone (id INTEGER AUTOINCREMENT ,title TEXT , location TEXT NOT NULL , message TEXT , time DOUBLE , dialog TEXT NOT NULL , status TEXT )");
        print("run");
      },
      version: 1
    );
  }
}
class StoryDataBase extends CoreDatabase{
  add()async{
    Database db= await database();
    int id=await db.insert('caseone', toMap());
    print(id);
  }
}