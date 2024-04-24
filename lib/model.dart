import 'package:flutter/material.dart';
import 'package:flutter_cube/flutter_cube.dart';
class model extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return modelstate();
  }

}
class modelstate extends State<model>{
  late Object nik;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nik = Object(fileName: 'assets/cube/untitled.obj');
    nik.position.setValues(0, 0, 0);
    nik.updateTransform();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/cube/bk.png"),fit: BoxFit.cover)),
        child: Cube(
          onSceneCreated: (Scene scene) {
            scene.world.add(nik);
            scene.camera.zoom = 8;
            scene.light.position;
            scene.world.lighting =true;

          },
        ),
      ),
    );
  }

}