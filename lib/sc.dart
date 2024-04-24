import 'package:flutter/material.dart';
import 'package:circle_list/circle_list.dart';
import 'package:nullbox/Home.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class WheelExample extends StatelessWidget {
  final controller=ScrollController();
  Widget _Builditem(int i){
    return Container(
      width: 100,
      color: Colors.white,
      height: 300,
      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(pic[i]))),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Wheel example'),
      ),
      body:SizedBox(
      height: 250,
    child: ScrollSnapList(
      listController: controller,
    itemBuilder: buildListItem,
    itemCount: pic.length,
    itemSize: 150,
    onItemFocus: (index) {},
    dynamicItemSize: true,
    ),
    )
    );
  }
}
Widget buildListItem(BuildContext context, int index) {
  return SizedBox(
    width: 150,
    height: 300,
    child: Card(
      elevation: 12,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "$index",
              style: const TextStyle(fontSize: 15),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'product.cost',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Reviews',
                    style: const TextStyle(color: Colors.blue),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WheelExample(),
    );
  }
}

void main() => runApp(MyApp());